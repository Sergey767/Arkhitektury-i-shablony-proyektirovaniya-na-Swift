//
//  СonsecutiveQuestionsStrategy.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 05.12.2020.
//

import Foundation

class СonsecutiveQuestionsStrategy: CreateQuestionStrategy {

    
    var currentQuestionPos: Int = 0
    
    var questions: [Question] = []
    
    var currentQuestion: Question?
    
    func nextQuestion() {
        if(currentQuestionPos < questions.count) {
            currentQuestionPos += 1
            currentQuestion = questions[currentQuestionPos]
        }
    }
    
    
}
