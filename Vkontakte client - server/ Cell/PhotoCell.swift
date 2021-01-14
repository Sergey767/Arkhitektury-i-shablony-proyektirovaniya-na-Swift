//
//  PhotoCell.swift
//  Vkontakte
//
//  Created by Серёжа on 11/07/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCell: UICollectionViewCell {

    static let reuseIdentifier = "PhotoCell"

    @IBOutlet private weak var photoImageView: UIImageView!

    func configure(with photoViewModel: PhotoViewModel) {
        photoImageView.kf.setImage(with: photoViewModel.url)
    }
}
