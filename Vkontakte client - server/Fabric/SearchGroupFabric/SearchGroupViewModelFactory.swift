//
//  SearchGroupViewModelFactory.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 13.01.2021.
//  Copyright © 2021 appleS. All rights reserved.
//

import Foundation

class SearchGroupViewModelFactory {
    
    func constructViewModel(from searchGroup: [SearchGroup]) -> [SearchGroupViewModel] {
        return searchGroup.compactMap(viewModel)
    }

    private func viewModel(from searchGroup: SearchGroup) -> SearchGroupViewModel {
        let name = searchGroup.name
        let urlImage = searchGroup.photo
        
        return SearchGroupViewModel(name: name, urlImage: urlImage)
    }
}
