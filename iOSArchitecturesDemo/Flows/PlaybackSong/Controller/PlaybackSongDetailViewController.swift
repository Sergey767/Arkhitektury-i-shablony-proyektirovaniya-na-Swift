//
//  PlaybackSongDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Сергей Горячев on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class PlaybackSongDetailViewController: UIViewController {
    
    lazy var playbackSongViewController = PlaybackSongViewController()
    
    private var playbackSongDetailView: PlaybackSongDetailView {
        return self.view as! PlaybackSongDetailView
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = PlaybackSongDetailView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Private
    
    private func configureUI() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
        
        addChildViewController()
    }
    
    private func addChildViewController() {
        self.addChild(playbackSongViewController)
        self.view.addSubview(playbackSongViewController.view)

        self.playbackSongViewController.didMove(toParent: self)

        playbackSongViewController.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            playbackSongViewController.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            playbackSongViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            playbackSongViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
}
