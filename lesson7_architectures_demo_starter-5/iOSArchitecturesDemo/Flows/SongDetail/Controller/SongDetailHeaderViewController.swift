//
//  SongDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Сергей Горячев on 03.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongDetailHeaderViewController: UIViewController {
    
    private let song: ITunesSong
    
    private let imageDownLoader = ImageDownloader()
    
    private var songDetailHeaderView: SongDetailHeaderView {
        return self.view as! SongDetailHeaderView
    }
    
    init(song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = SongDetailHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillData()
    }
    
    private func fillData() {
        downloadImage()
        songDetailHeaderView.titleLabel.text = song.trackName
        songDetailHeaderView.subtitleLabel.text = song.artistName
        songDetailHeaderView.collectionLabel.text = song.collectionName
    }
    
    private func downloadImage() {
        guard let url = self.song.artwork else { return }
        
        imageDownLoader.getImage(fromUrl: url) { [weak self] (image, _) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.songDetailHeaderView.imageView.image = image
            }
        }
    }
}
