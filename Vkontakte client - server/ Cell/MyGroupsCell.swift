//
//  MyGroupsCell.swift
//  Vkontakte
//
//  Created by Серёжа on 11/07/2019.
//  Copyright © 2019 appleS. All rights reserved.
//

import UIKit
import Kingfisher

class MyGroupsCell: UITableViewCell {
    
    static let reuseIdentifier = "MyGroupsCell"
    
    @IBOutlet private weak var groupsName: UILabel!
    @IBOutlet weak var myGroupsImageView: UIImageView!
    
    override func awakeFromNib() {
        myGroupsImageView.layer.cornerRadius = myGroupsImageView.frame.size.width / 2
        myGroupsImageView.clipsToBounds = true
    }
    
    func configure(with myGroupsViewModel: MyGroupsViewModel) {
        groupsName.text = myGroupsViewModel.name
        myGroupsImageView.kf.setImage(with: myGroupsViewModel.url)
    }
}
