//
//  SearchSongPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Сергей Горячев on 02.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation
import UIKit

protocol SearchSongViewInput: AnyObject {
    var searchResults: [ITunesSong] { get set }
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchSongViewOutput: AnyObject {
    func viewDidSearch(with query: String)
    func viewDidSelectSong(_ song: ITunesSong)
}

class SearchSongPresenter {
    private let searchService = ITunesSearchService()
    
    weak var viewSongInput: (UIViewController & SearchSongViewInput)?
    
    private func requestSongs(with query: String) {
        searchService.getSongs(forQuery: query) { [weak self] (result) in
            guard let self = self else { return }
            
            self.viewSongInput?.throbber(show: false)
            result.withValue { (songs) in
                guard !songs.isEmpty else {
                    self.viewSongInput?.showNoResults()
                    return
                }
                self.viewSongInput?.hideNoResults()
                self.viewSongInput?.searchResults = songs
            }.withError { (error) in
                self.viewSongInput?.showError(error: error)
            }
        }
    }
    
    private func openSongDetails(with song: ITunesSong) {
        let songDetailViewController = SongDetailViewController(song: song)
        viewSongInput?.navigationController?.pushViewController(songDetailViewController, animated: true)
    }
}

extension SearchSongPresenter: SearchSongViewOutput {
    func viewDidSearch(with query: String) {
        requestSongs(with: query)
    }
    
    func viewDidSelectSong(_ song: ITunesSong) {
        openSongDetails(with: song)
    }
}
