//
//  GameViewController.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 01.11.2020.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet private weak var questionLabel: UILabel!
    
    @IBOutlet private weak var answerA: UIButton!
    @IBOutlet private weak var answerB: UIButton!
    @IBOutlet private weak var answerC: UIButton!
    @IBOutlet private weak var answerD: UIButton!
    
    var questions: [Question] = [
        Question(question: "Что из перечисленного пирог ?", answers: ["кусака", "закаляка", "забияка", "кулебяка"], correctAnswer: 3),
        Question(question: "Провожают, как известно, по уму, а как встречают ?", answers: ["по одёжке", "по сберкнижке", "по прописке", "по рекомендации"], correctAnswer: 0),
        Question(question: "Как называют мелководный бассейн, предназначенный для детей ?", answers: ["утятник", "лягушатник", "селёдочник", "тюленник"], correctAnswer: 1),
        Question(question: "Бочонок с каким числом в русском лото принято называть «топориками» ?", answers: ["11", "69", "77", "88"], correctAnswer: 2),
        Question(question: "Что из перечисленного название концертного зала, а не стадиона ?", answers: ["«Камп Ноу»", "«Альберт-холл»", "«Сан-Сиро»", "«Энфилд»"], correctAnswer: 1),
        Question(question: "Что норвежцы дарят на Новый год в качестве символа тепла и счастья ?", answers: ["дрова", "свечи", "спички", "пледы"], correctAnswer: 2)
    ]
    
    var currentQuestion: Question?
    var currentQuestionPos = 0
    var noCorrect = 0
    
    var onGameEnd: ((Int) -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentQuestion = questions[0]
        setQuestion()
    }
    
    @IBAction func submitAnswerA(_ sender: Any) {
        checkAnswer(idx: 0)
    }
    
    @IBAction func submitAnswerB(_ sender: Any) {
        checkAnswer(idx: 1)
    }
    
    @IBAction func submitAnswerC(_ sender: Any) {
        checkAnswer(idx: 2)
    }
    
    @IBAction func submitAnswerD(_ sender: Any) {
        checkAnswer(idx: 3)
    }
    
    func checkAnswer(idx: Int) {
        if(idx == currentQuestion!.correctAnswer) {
            noCorrect += 1
            loadNextQuestion()
        } else {
            
            let gameSession = GameSession(numberResolvedIssues: noCorrect, numberQuestions: questions.count)
            GameSingleton.shared.addGameSession(session: gameSession)
            
            var percentRight = Double(noCorrect) / Double(questions.count)
            percentRight *= 100
            
            GameSingleton.shared.percentRight = percentRight
            
            onGameEnd?(noCorrect)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func loadNextQuestion() {
        if(currentQuestionPos + 1 < questions.count) {
            currentQuestionPos += 1
            currentQuestion = questions[currentQuestionPos]
            setQuestion()
        }
    }
    
    func setQuestion() {
        questionLabel.text = currentQuestion!.question
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.numberOfLines = 0
        answerA.setTitle(currentQuestion!.answers[0], for: .normal)
        answerB.setTitle(currentQuestion!.answers[1], for: .normal)
        answerC.setTitle(currentQuestion!.answers[2], for: .normal)
        answerD.setTitle(currentQuestion!.answers[3], for: .normal)
    }

}
