//
//  SearchGroupTableViewController.swift
//  Vkontakte
//
//  Created by Серёжа on 29/06/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit

class SearchGroupTableViewController: UITableViewController, VkApiSearchGroupsDelegate {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    //let networkService = NetworkService()
    private var networkServiceAdapter = NetworkServiceAdapter()
    private var photoService: PhotoService?
    
    private var searchGroupViewModel: [SearchGroupViewModel] = []
    private let searchGroupViewModelFactory = SearchGroupViewModelFactory()
    
    private var searchGroups = [SearchGroup]()
    private var timer: Timer?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photoService = PhotoService(container: tableView)
        
        setupSearchBar()
        setupColorFontSearchBar()
        
        tableView.tableFooterView = UIView()
    }
    
    private func setupColorFontSearchBar() {
        let searchBar = searchController.searchBar
        searchBar.tintColor = UIColor.tintColor
        
        if #available(iOS 13.0, *) {
            searchController.searchBar.searchTextField.backgroundColor = UIColor.backgroundColor
            searchController.searchBar.searchTextField.textColor = UIColor.textColor
        }
        
        if let navigationbar = self.navigationController?.navigationBar {
            navigationbar.barTintColor = UIColor.barTintColor
        }
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.searchTextFieldFont
    }
 
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    func returnSearchGroups(_ searchGroups: [SearchGroup]) {
//        self.searchGroups = searchGroups
//        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchGroupViewModel.count//searchGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchGroupCell") as! SearchGroupCell
        
        //let searchGroup = searchGroups[indexPath.row]
        let searchGroup = searchGroupViewModel[indexPath.row]
        //let urlImage = searchGroup.photo
        let image = photoService?.getPhoto(atIndexPath: indexPath, byUrl: searchGroup.urlImage)
        
        cell.searchGroupImageView.image = image
        
        cell.searchGroupImageView.layer.cornerRadius = cell.searchGroupImageView.frame.size.width / 2
        cell.searchGroupImageView.clipsToBounds = true
        
        cell.configure(with: searchGroup)
        
        return cell
    }
}

    // MARK - UISearchBarDelegate
extension SearchGroupTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { [self] (_) in
            self.networkServiceAdapter.loadSearchGroups(searchQuery: searchText) { [weak self] searchGroups in
                self?.searchGroups = searchGroups
                self?.searchGroupViewModel = self?.searchGroupViewModelFactory.constructViewModel(from: searchGroups) ?? []
                self?.tableView.reloadData()
            }
            //self.networkService.loadSearchGroups(searchQuery: searchText, delegate: self)
        })
    }
}
