//
//  GameSession.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 05.11.2020.
//

import Foundation

class GameSession: Codable {
    
    var currentQuestionsNumber = Observable<Int>(0)
    var percentСorrectQuestions = Observable<Double>(0.0)
    var numberResolvedIssues: Int?
    var numberQuestions:Int?
    
    enum CodingKeys: CodingKey {
        case percentСorrectQuestions, currentQuestionsNumber
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        percentСorrectQuestions.value = try container.decode(Double.self, forKey: .percentСorrectQuestions)
        currentQuestionsNumber.value = try container.decode(Int.self, forKey: .currentQuestionsNumber)
    }

    init(percentСorrectQuestions: Observable<Double>, currentQuestionsNumber: Observable<Int>, numberResolvedIssues: Int, numberQuestions: Int) {
        self.percentСorrectQuestions.value = percentСorrectQuestions.value
        self.currentQuestionsNumber.value = currentQuestionsNumber.value
        self.numberResolvedIssues = numberResolvedIssues
        self.numberQuestions = numberQuestions
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(percentСorrectQuestions.value, forKey: .percentСorrectQuestions)
        try container.encode(currentQuestionsNumber.value, forKey: .currentQuestionsNumber)
    }
}
