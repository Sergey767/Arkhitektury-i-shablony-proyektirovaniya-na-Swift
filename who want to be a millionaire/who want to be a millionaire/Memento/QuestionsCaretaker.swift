//
//  QuestionsCaretaker.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 15.12.2020.
//

import Foundation

class QuestionsCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private let key = "key"
    
    func saveQuestion(questionArr: [Question?]) {
        do {
            let data = try self.encoder.encode(questionArr)
            UserDefaults.standard.setValue(data, forKey: key)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadQuestion() -> [Question]? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        do {
            return try decoder.decode([Question].self, from: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}
