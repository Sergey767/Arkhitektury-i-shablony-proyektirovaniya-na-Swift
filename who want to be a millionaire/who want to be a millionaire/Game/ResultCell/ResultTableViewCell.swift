//
//  ResultTableViewCell.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 05.11.2020.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberResolvedIssuesLabel: UILabel!
    @IBOutlet weak var numberQuestionsLabel: UILabel!
    @IBOutlet weak var percentRightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberResolvedIssuesLabel.lineBreakMode = .byWordWrapping
        numberResolvedIssuesLabel.numberOfLines = 0
        
        numberQuestionsLabel.lineBreakMode = .byWordWrapping
        numberQuestionsLabel.numberOfLines = 0
        
        percentRightLabel.lineBreakMode = .byWordWrapping
        percentRightLabel.numberOfLines = 0
    }
    
}
