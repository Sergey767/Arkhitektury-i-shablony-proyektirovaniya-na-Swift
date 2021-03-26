//
//  PlaybackSongDetailView.swift
//  iOSArchitecturesDemo
//
//  Created by Сергей Горячев on 18.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

final class PlaybackSongDetailView: UIView {
    
    // MARK: - Subviews
    
    let throbber = UIActivityIndicatorView(style: .gray)
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    
    private func configureUI() {
        self.backgroundColor = .white
        self.addImageViewThrobber()
//        self.setupConstraints()
    }
    
    private func addImageViewThrobber() {
        self.throbber.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            self.throbber.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.throbber.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
}
