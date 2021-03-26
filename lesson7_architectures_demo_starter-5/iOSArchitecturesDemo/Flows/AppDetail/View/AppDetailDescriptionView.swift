//
//  AppDetailDescriptionView.swift
//  iOSArchitecturesDemo
//
//  Created by Сергей Горячев on 27.02.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class AppDetailDescriptionView: UIView {
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        return label
    }()
    
    private(set) lazy var versionHistoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .blue
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private(set) lazy var versionNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private(set) lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private(set) lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        SetUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func SetUI() {
        self.addSubview(titleLabel)
        self.addSubview(versionNumberLabel)
        self.addSubview(descriptionLabel)
        self.addSubview(versionHistoryLabel)
        self.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            versionHistoryLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            versionHistoryLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 30),
            versionHistoryLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            
            versionNumberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            versionNumberLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            versionNumberLabel.heightAnchor.constraint(equalToConstant: 15),
            
            dateLabel.topAnchor.constraint(equalTo: versionHistoryLabel.bottomAnchor, constant: 12),
            dateLabel.leftAnchor.constraint(equalTo: versionHistoryLabel.leftAnchor),
            dateLabel.rightAnchor.constraint(equalTo: versionHistoryLabel.rightAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: versionNumberLabel.bottomAnchor, constant: 12),
            descriptionLabel.leftAnchor.constraint(equalTo: versionNumberLabel.leftAnchor),
            descriptionLabel.rightAnchor.constraint(equalTo: dateLabel.rightAnchor)
        ])
    }
    
    
    
}
