//
//  ResultViewController.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 06.11.2020.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "ResultTableViewCell", bundle: nil), forCellReuseIdentifier: "ResultTableViewCell")
        tableView.dataSource = self
    }
}

extension ResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        GameSingleton.shared.gameSession.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell", for: indexPath) as? ResultTableViewCell {
            
            let gameSession = GameSingleton.shared.gameSession[indexPath.row]
            cell.numberResolvedIssuesLabel.text = "Правильно решено вопросов \(gameSession?.numberResolvedIssues ?? 0)"
            cell.numberQuestionsLabel.text = "Всего вопросов \(gameSession?.numberQuestions ?? 0)"
            
            let percentRight = GameSingleton.shared.percentRight
            cell.percentRightLabel.text = "Процент правильных ответов \(ceil(percentRight ?? 0))"
            
            return cell
        } else {
            return UITableViewCell()
        }
    }
}
