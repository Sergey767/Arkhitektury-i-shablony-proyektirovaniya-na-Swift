//
//  UsersViewModelFactory.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 07.01.2021.
//  Copyright © 2021 appleS. All rights reserved.
//

import UIKit

class UsersViewModelFactory {
    
    func constructViewModel(from friends: [User]) -> [UsersViewModel] {
        return friends.compactMap(viewModel)
    }
    
    private func viewModel(from friends: User) -> UsersViewModel {
        let id = friends.id
        let name = friends.firstName + " " + friends.lastName
        let avatar = URL(string: friends.avatar)

        return UsersViewModel(id: id, name: name, avatar: avatar)
    }
}
