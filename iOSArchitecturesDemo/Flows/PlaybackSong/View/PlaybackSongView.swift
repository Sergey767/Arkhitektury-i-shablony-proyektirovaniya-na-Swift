//
//  PlaybackSongView.swift
//  iOSArchitecturesDemo
//
//  Created by Сергей Горячев on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class PlaybackSongView: UIView {
    
    var viewModel: (PlaybackViewModelInput & PlaybackViewModelOutput)?

    private(set) lazy var progressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()

    private(set) lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        button.layer.cornerRadius = 16.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(self.playButtonClicked), for: .touchUpInside)

        return button
    }()

    private(set) lazy var pauseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Pause", for: .normal)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        button.layer.cornerRadius = 16.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(self.pauseButtonClicked), for: .touchUpInside)

        return button
    }()

    private(set) lazy var stopButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Stop", for: .normal)
        button.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        button.layer.cornerRadius = 16.0
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(self.stopButtonClicked), for: .touchUpInside)

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func playButtonClicked() {
        viewModel?.play()
    }
    
    @objc func pauseButtonClicked() {
        viewModel?.pause()
    }
    
    @objc func stopButtonClicked() {
        viewModel?.stop()
    }

    private func setUI() {
        self.addSubview(progressView)
        self.addSubview(playButton)
        self.addSubview(pauseButton)
        self.addSubview(stopButton)

        NSLayoutConstraint.activate([
            progressView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 100),
            progressView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            progressView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),

            playButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 30),
            playButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 40),
            playButton.widthAnchor.constraint(equalToConstant: 80),
            playButton.heightAnchor.constraint(equalToConstant: 32),

            pauseButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 30),
            pauseButton.leftAnchor.constraint(equalTo: playButton.rightAnchor, constant: 40),
            pauseButton.widthAnchor.constraint(equalToConstant: 80),
            pauseButton.heightAnchor.constraint(equalToConstant: 32),

            stopButton.topAnchor.constraint(equalTo: progressView.bottomAnchor, constant: 30),
            stopButton.leftAnchor.constraint(equalTo: pauseButton.rightAnchor, constant: 40),
            stopButton.widthAnchor.constraint(equalToConstant: 80),
            stopButton.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
