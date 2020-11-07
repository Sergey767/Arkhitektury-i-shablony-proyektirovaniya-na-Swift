//
//  GameSession.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 05.11.2020.
//

import Foundation

class GameSession: Codable {
    let numberResolvedIssues: Int
    let numberQuestions: Int
    
    init(numberResolvedIssues: Int, numberQuestions: Int) {
        self.numberResolvedIssues = numberResolvedIssues
        self.numberQuestions = numberQuestions
    }
}
