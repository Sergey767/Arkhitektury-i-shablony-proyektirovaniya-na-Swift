//
//  SearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Сергей Горячев on 15.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SearchRouterInput {
    func openDetails(for song: ITunesSong)
    //func openSongInItunes(song: ITunesSong)
}

class SearchRouter: SearchRouterInput {
    weak var viewController: UIViewController?
    
    func openDetails(for song: ITunesSong) {
        let songDetailViewController = SongDetailViewController(song: song)
        viewController?.navigationController?.pushViewController(songDetailViewController, animated: true)
    }
}
