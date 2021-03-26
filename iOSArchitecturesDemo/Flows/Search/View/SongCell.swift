//
//  SongCell.swift
//  iOSArchitecturesDemo
//
//  Created by Сергей Горячев on 03.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation
import UIKit

final class SongCell: UITableViewCell {
    
    // MARK: - Subviews
    
    private(set) lazy var imageSongView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16.0)
        return label
    }()
    
    private(set) lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13.0)
        return label
    }()
    
    private(set) lazy var collectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 12.0)
        return label
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - Methods
    
    func configure(with cellModel: SongCellModel) {
        self.titleLabel.text = cellModel.title
        self.subtitleLabel.text = cellModel.subtitle
        self.collectionLabel.text = cellModel.collection
        
        let urlImage = URL(string: cellModel.imageSong ?? "")
        guard let url = urlImage else { return }
        let dataUrl = try? Data(contentsOf: url)
        guard let data = dataUrl else { return }
        self.imageSongView.image = UIImage(data: data)
    }
    
    // MARK: - UI
    
    override func prepareForReuse() {
        [self.titleLabel, self.subtitleLabel, self.collectionLabel].forEach { $0.text = nil }
    }
    
    private func configureUI() {
        self.addImageSongView()
        self.addTitleLabel()
        self.addSubtitleLabel()
        self.addCollectionLabel()
    }
    
    private func addImageSongView() {
        self.contentView.addSubview(self.imageSongView)
        NSLayoutConstraint.activate([
            imageSongView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5.0),
            imageSongView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10.0),
            imageSongView.heightAnchor.constraint(equalToConstant: 50.0),
            imageSongView.widthAnchor.constraint(equalToConstant: 50.0)
        ])
    }
    
    private func addTitleLabel() {
        self.contentView.addSubview(self.titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 5.0),
            titleLabel.leftAnchor.constraint(equalTo: imageSongView.rightAnchor, constant: 10.0),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0)
        ])
    }
    
    private func addSubtitleLabel() {
        self.contentView.addSubview(self.subtitleLabel)
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5.0),
            subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
            subtitleLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor)
        ])
    }
    
    private func addCollectionLabel() {
        self.contentView.addSubview(self.collectionLabel)
        NSLayoutConstraint.activate([
            collectionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 5.0),
            collectionLabel.leftAnchor.constraint(equalTo: imageSongView.rightAnchor, constant: 10.0),
            collectionLabel.rightAnchor.constraint(equalTo: subtitleLabel.rightAnchor)
        ])
        
    }
    
    
    
    
    
}
