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
    
    private var labels = [UILabel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labels = [numberResolvedIssuesLabel, numberQuestionsLabel, percentRightLabel]
        
        labels.forEach {
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
        }
    }
    
}
