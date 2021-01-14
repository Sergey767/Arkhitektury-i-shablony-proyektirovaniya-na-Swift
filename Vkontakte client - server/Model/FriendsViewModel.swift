//
//  FriendsViewModel.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 18.10.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import Foundation
import PromiseKit

class FriendsViewModel {
    
    //private var networkService = NetworkService()
    private var networkServiceAdapter = NetworkServiceAdapter()
    
    private var usersViewModel: [UsersViewModel] = []
    private let userViewModelFactory = UsersViewModelFactory()
    
    init(networkServiceAdapter: NetworkServiceAdapter) {
        self.networkServiceAdapter = networkServiceAdapter
    }
    
    func launchPromiseFriendsChain() {
        firstly {
            networkServiceAdapter.getPromiseFriends(token: Singleton.instance.token)
        }
            .get { [weak self] friends in
                try? RealmProvider.save(items: friends)
                self?.usersViewModel = self?.userViewModelFactory.constructViewModel(from: friends) ?? []
            }
            .catch { error in
                print(error)
            }
            .finally {
            }
    }
}
