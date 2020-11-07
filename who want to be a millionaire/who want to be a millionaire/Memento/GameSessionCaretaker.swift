//
//  GameSessionCaretaker.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 07.11.2020.
//

import Foundation

class GameSessionCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let key = "key"
    
    func saveGameSession(sessions: [GameSession?]) {
        do {
            let data = try encoder.encode(sessions)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadGameSession() -> [GameSession]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        
        do {
            return try decoder.decode([GameSession].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
