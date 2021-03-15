//
//  MyFriendsViewController.swift
//  Vkontakte
//
//  Created by Серёжа on 24/08/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit
import RealmSwift
import PromiseKit

class MyFriendsViewController: UIViewController, UISearchBarDelegate, VkApiFriendsDelegate {
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchBar: UISearchBar!
    
    private var networkServiceAdapter = NetworkServiceAdapter()
    private var notificationToken: NotificationToken?
    
    lazy var loggingProxy = NetworkServiceAdapterLoggingProxy(networkServiceAdapter: networkServiceAdapter)
    
    private var usersViewModel: [UsersViewModel] = []
    private let userViewModelFactory = UsersViewModelFactory()

    var friendsViewModel: FriendsViewModel? 
    var sortedIds = [[Int?]]()
    var cashedFriendsIds = [Int?]()
    private var searchText: String {
        searchBar.text ?? ""
    }
    
    var sortedFriends = [[User]]() {
        didSet {
            sortedIds = sortedFriends.map { $0.map { $0.id } }
            if let friends: Results<User> = try? RealmProvider.get(User.self) {
                self.cashedFriendsIds = Array(friends).map { $0.id }
            } else {
                cashedFriendsIds.removeAll()
            }
        }
    }

    private var filteredFriends: Results<User>? {
        let friends: Results<User>? = try? RealmProvider.get(User.self)
        guard !searchText.isEmpty else { return friends }
        return friends?.filter("lastName CONTAINS[cd] %@", searchText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let friendsViewModel = FriendsViewModel(networkServiceAdapter: NetworkServiceAdapter())
        let myFriendsViewController = MyFriendsViewController()
        myFriendsViewController.friendsViewModel = friendsViewModel
        
        //getFriends()
        
//        let realm = try! Realm()
//            try! realm.write {
//                realm.delete(filteredFriends!)
//
//        }
        //friendsViewModel.launchPromiseFriendsChain()
        firstly {
            loggingProxy.getPromiseFriends(token: Singleton.instance.token)
        }
            .get { [weak self] friends in
                try? RealmProvider.save(items: friends)
                self?.usersViewModel = self?.userViewModelFactory.constructViewModel(from: friends) ?? []
                self?.tableView.reloadData()
            }
            .catch { error in
                print(error)
            }
            .finally {
            }
        
        //notification()
        
        setupFontSearchBar()
        
        searchBar.delegate = self
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
    private func setupFontSearchBar() {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).font = UIFont.searchFriendsTextFieldFont
    }
    
//    private func getFriends() {
//        notification()
//        networkService.loadFriends(token: Singleton.instance.token, delegate: self)
//    }
    
//    private func notification() {
//        notificationToken = filteredFriends?.observe { [weak self] change in
//            guard let self = self else { return }
//            switch change {
//            case .initial:
//                self.sortFriends()
//                self.tableView.reloadData()
//            case .update(_, let deletions, let insertions, let modifications):
//
//                let deletions = deletions.compactMap { self.getUserIndexPathByRealmOrder(order: $0) }
//
//                let modifications = modifications.compactMap { self.getUserIndexPathByRealmOrder(order: $0) }
//
//                self.sortFriends()
//
//                let insertions = insertions.compactMap { self.getUserIndexPathByRealmOrder(order: $0) }
//
//                guard insertions.count == 0 else {
//                    self.tableView.reloadData()
//                    return
//                }
//
//                self.tableView.beginUpdates()
//
//                if !modifications.isEmpty {
//                    self.tableView.reloadRows(at: modifications, with: .automatic)
//                }
//                if !deletions.isEmpty {
//                    let rowsInDeleteSections = Set(deletions.map { $0.section })
//                        .compactMap { ($0, self.tableView.numberOfRows(inSection: $0)) }
//                    let sectionsWithOneCell = rowsInDeleteSections.filter { section, count in count == 1 }.map { section, _ in section }
//                    let sectionsWithMoreCells = rowsInDeleteSections.filter { section, count in count > 1 }.map { section, _ in section }
//                    if sectionsWithOneCell.count > 0 {
//                        self.tableView.deleteSections(IndexSet(sectionsWithOneCell), with: .automatic)
//                    }
//                    if sectionsWithMoreCells.count > 0 {
//                        let indexForDeletion = deletions.filter { sectionsWithMoreCells.contains($0.section) }
//                        self.tableView.deleteRows(at: indexForDeletion, with: .automatic)
//                    }
//                }
//
//                self.tableView.endUpdates()
//
//            case .error(let error):
//                self.show(error)
//            }
//        }
//    }
    
    private func sortFriends() {
        sortedFriends.removeAll()
        
        guard let filteredFriends = filteredFriends else { return }
        let friends: [User] = Array(filteredFriends)
        var sortedFriends = [[User]]()
        
        let groupedElements = Dictionary(grouping: friends) { friends -> String in
            return String(friends.lastName.prefix(1))
        }
        let sortedKeys = groupedElements.keys.sorted()
        sortedKeys.forEach { key in
            if let values = groupedElements[key] {
                sortedFriends.append(values)
            }
        }
        self.sortedFriends = sortedFriends
    }
    
    func returnFriends(_ friends: [User]) {
    }
    
    private func getUserIndexPathByRealmOrder(order: Int) -> IndexPath? {
        guard order < cashedFriendsIds.count, let userId = cashedFriendsIds[order] else { return nil }
        
        guard let section = sortedIds.firstIndex(where: { $0.contains(userId) }),
            let item = sortedIds[section].firstIndex(where: { $0 == userId }) else { return nil }
        return IndexPath(item: item, section: section)
    }
    
    // MARK: - Search Bar delegate methods
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sortFriends()
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoSegue",
            let photoController = segue.destination as? PhotoCollectionViewController,
            let indexPath = tableView.indexPathForSelectedRow {

//            let friendValues = sortedFriends[indexPath.section]
//            let friend = friendValues[indexPath.row]
            let friend = usersViewModel[indexPath.row]

            photoController.userId = friend.id
            photoController.friendTitle = friend.name
        }
    }
}

    // MARK: - Table view data source, delegate methods

extension MyFriendsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return sortedFriends.count
        return usersViewModel.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //sortedFriends[section].count
        return usersViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "MyFriendsCell", for: indexPath) as! MyFriendsCell
        
        //let friendModel = sortedFriends[indexPath.section][indexPath.item]
        
        cell.configure(with: usersViewModel[indexPath.row])
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        String(sortedFriends[section].first?.lastName.first ?? Character(""))
//    }
}
