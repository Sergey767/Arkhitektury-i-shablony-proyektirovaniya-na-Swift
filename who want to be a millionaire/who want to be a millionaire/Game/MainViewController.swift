//
//  MainViewController.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 01.11.2020.
//

import UIKit

protocol MainVCDelegate: AnyObject {
    
    func loadNextQuestion(createQuestionStrategy: CreateQuestionStrategy, questionMode: QuestionMode)
}

class MainViewController: UIViewController {

    @IBOutlet private weak var resultsButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var settingsButton: UIButton!
    @IBOutlet weak var addQuestionButton: UIButton!
    
    weak var mainVCDelegate: MainVCDelegate?
    
    var createQuestionStrategy: CreateQuestionStrategy?
    var questionMode: QuestionMode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender senser: Any?) {
        switch segue.identifier {
        case "to_gameVC":
            if let destination = segue.destination as? GameViewController {
                destination.onGameEnd = { [weak self] (result) in
                    guard let self = self else { return }
                    self.resultLabel.text = "your last result is: \(result)"
                }
                guard let questiomMode = questionMode else { return }
                destination.questionMode = questiomMode
            }
        default:
            break
        }
    }
    
    @IBAction func didTapNewGame(_ sender: UIButton) {
        performSegue(withIdentifier: "to_gameVC", sender: self)
    }
}

