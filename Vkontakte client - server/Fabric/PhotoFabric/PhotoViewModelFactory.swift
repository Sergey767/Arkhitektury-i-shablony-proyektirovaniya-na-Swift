//
//  PhotoViewModelFactory.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 08.01.2021.
//  Copyright © 2021 appleS. All rights reserved.
//

import Foundation

class PhotoViewModelFactory {
    
    func constructViewModel(from photo: [Photo]) -> [PhotoViewModel] {
        return photo.compactMap(viewModel)
    }
    
    private func viewModel(from photo: Photo) -> PhotoViewModel {
        let url = URL(string: photo.urlString)
        
        return PhotoViewModel(url: url)
    }
}
