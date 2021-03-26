//
//  MyPhotoCollectionViewController.swift
//  Vkontakte
//
//  Created by Серёжа on 29/06/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit
import RealmSwift

class PhotoCollectionViewController: UICollectionViewController, VkApiPhotosDelegate {
    
    //let networkService = NetworkService()
    private var networkServiceAdapter = NetworkServiceAdapter()
//    private lazy var photos = try? Realm().objects(User.self).filter("userId == %@", userId)
    lazy var loggingProxy = NetworkServiceAdapterLoggingProxy(networkServiceAdapter: networkServiceAdapter)
    
    private var photoViewModel: [PhotoViewModel] = []
    
    private let photoViewModelFactory = PhotoViewModelFactory()
    
    private var notificationToken: NotificationToken?

    public var userId: Int?
    var friendTitle = ""

    override func viewDidLoad() {
        super.viewDidLoad()
     
        //fetchPhotos()
    
        if let userId = userId {
            loggingProxy.fetchPhotos(for: userId) { [weak self] photos in
                try? RealmProvider.save(items: photos)
                self?.photoViewModel = self?.photoViewModelFactory.constructViewModel(from: photos) ?? []
                self?.collectionView.reloadData()
            }
        }
        
//        notificationToken = photoViewModelFactory.observe { [weak self] change in
//            guard let self = self else { return }
//            switch change {
//            case .initial:
//                break
//            case .update:
//                self.collectionView.reloadData()
//            case .error(let error):
//                self.show(error)
//            }
//        }

        self.title = friendTitle
    }
    
//    func convertArray<T, U>(array: [T]) -> [U] {
//        var newArray = [U]()
//        for element in array {
//            guard let newElement = element as? U else {
//                print("downcast failed!")
//                return []
//            }
//            newArray.append(newElement)
//        }
//        return newArray
//    }
    
    func returnPhotos(_ photos: [Photo]) {
    }
    
//    func fetchPhotos() {
//
//        notificationToken = photos?.observe { [weak self] change in
//            guard let self = self else { return }
//            switch change {
//            case .initial:
//                break
//            case .update:
//                self.collectionView.reloadData()
//            case .error(let error):
//                self.show(error)
//            }
//        }
//
//        if let userId = userId {
//            networkService.fetchPhotos(for: userId, delegate: self)
//        }
//    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoViewModel.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        
        let photo = photoViewModel[indexPath.row]
        cell.configure(with: photo)

        return cell
    }
}

