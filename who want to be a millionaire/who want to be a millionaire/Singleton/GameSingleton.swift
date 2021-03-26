//
//  GameSingleton.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 06.11.2020.
//

import Foundation

class GameSingleton {
    static let shared = GameSingleton()
    
    private(set) var gameSession: [GameSession?] {
        didSet {
            gameSessionCaretaker.saveGameSession(sessions: gameSession)
        }
    }
    
    private let gameSessionCaretaker = GameSessionCaretaker()
    
    private(set) var questionArr: [Question?] {
        didSet {
            questionCaretaker.saveQuestion(questionArr: questionArr)
        }
    }
    
    private let questionCaretaker = QuestionsCaretaker()
    
    var percentRight: Double?
    
    private init() {
        gameSession = gameSessionCaretaker.loadGameSession() ?? []
        questionArr = questionCaretaker.loadQuestion() ?? []
    }
    
    func addGameSession(session: GameSession) {
        gameSession.append(session)
    }
    
    func clearGameSession() {
        gameSession.removeAll()
    }
    
    func addQuestion(question: Question) {
        questionArr.append(question)
    }
    
    func clearQuestion() {
        questionArr.removeAll()
    }
    
    var selectedQuestionMode = 0
}
