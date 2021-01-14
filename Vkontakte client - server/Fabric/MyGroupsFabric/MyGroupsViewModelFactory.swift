//
//  MyGroupsViewModelFactory.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 13.01.2021.
//  Copyright © 2021 appleS. All rights reserved.
//

import Foundation

class MyGroupsViewModelFactory {
    
    func constructViewModel(from group: [Group]) -> [MyGroupsViewModel] {
        return group.compactMap(viewModel)
    }

    private func viewModel(from group: Group) -> MyGroupsViewModel {
        let name = group.name
        let url = URL(string: group.photo)
        
        return MyGroupsViewModel(name: name, url: url)
    }
}
