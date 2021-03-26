//
//  PlaybackSongViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Сергей Горячев on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class PlaybackSongViewController: UIViewController {

    private var playbackSongView: PlaybackSongView {
        return self.view as! PlaybackSongView
    }

    override func loadView() {
        self.view = PlaybackSongView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        playbackSongView.viewModel = PlaybackViewModel(progress: 0, onProgressViewChanged: { [weak self] (progress) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.playbackSongView.progressView.setProgress(Float(progress), animated: true)
            }
        })
    }
}
