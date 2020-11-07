//
//  GameSingleton.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 06.11.2020.
//

import Foundation

class GameSingleton {
    static let shared = GameSingleton()
    
    //private(set) var gameSession: [GameSession?] = []
    private(set) var gameSession: [GameSession?] {
        didSet {
            gameSessionCaretaker.saveGameSession(sessions: gameSession)
        }
    }
    
    
    private let gameSessionCaretaker = GameSessionCaretaker()
    
    var percentRight: Double?
    
    private init() {
        gameSession = gameSessionCaretaker.loadGameSession() ?? []
    }
    
    func addGameSession(session: GameSession) {
        gameSession.append(session)
    }
    
    func clearGameSession() {
        gameSession.removeAll()
    }
    
}
