//
//  SearchSongBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Сергей Горячев on 03.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SearchSongBuilder {
    static func build() -> (UIViewController & SearchSongViewInput) {
        let presenter = SearchSongPresenter()
        let viewController = SearchSongsViewController(presenter: presenter)
        presenter.viewSongInput = viewController
        
        return viewController
    }
}
