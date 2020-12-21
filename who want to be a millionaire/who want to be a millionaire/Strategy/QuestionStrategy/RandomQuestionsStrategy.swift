//
//  RandomQuestionsStrategy.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 05.12.2020.
//

import Foundation

class RandomQuestionsStrategy: CreateQuestionStrategy {
    var questions: [Question] = []
    var currentQuestion: Question?
    var currentQuestionPos: Int = 0
    var randomQuestions = 0
    
    func nextQuestion() {
        randomQuestions = Int(arc4random()) % questions.count
        if(currentQuestionPos < questions.count) {
            currentQuestionPos = randomQuestions
            currentQuestion = questions[currentQuestionPos]
        }
    }
}
