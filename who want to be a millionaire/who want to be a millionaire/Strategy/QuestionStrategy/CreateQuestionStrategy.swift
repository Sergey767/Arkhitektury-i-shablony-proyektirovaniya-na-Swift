//
//  CreateQuestionStrategy.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 03.12.2020.
//

import Foundation

protocol CreateQuestionStrategy: AnyObject {
    
    var questions: [Question] { get set }
    
    var currentQuestion: Question? { get set }
    var currentQuestionPos: Int { get set }
    
    func nextQuestion()
    
}
