//
//  GameViewController.swift
//  who want to be a millionaire
//
//  Created by Сергей Горячев on 01.11.2020.
//

import UIKit

class GameViewController: UIViewController, MainVCDelegate {
    
    @IBOutlet private weak var questionLabel: UILabel!
    @IBOutlet weak var percentСorrectQuestionsLabel: UILabel!
    @IBOutlet weak var currentQuestionsNumberLabel: UILabel!
    
    @IBOutlet private var answerCollectionButton: [UIButton]!
 
    var questions: [Question] = [
        Question(question: "Что из перечисленного пирог ?", answers: ["кусака", "закаляка", "забияка", "кулебяка"], correctAnswer: 3),
        Question(question: "Провожают, как известно, по уму, а как встречают ?", answers: ["по одёжке", "по сберкнижке", "по прописке", "по рекомендации"], correctAnswer: 0),
        Question(question: "Как называют мелководный бассейн, предназначенный для детей ?", answers: ["утятник", "лягушатник", "селёдочник", "тюленник"], correctAnswer: 1),
        Question(question: "Бочонок с каким числом в русском лото принято называть «топориками» ?", answers: ["11", "69", "77", "88"], correctAnswer: 2),
        Question(question: "Что из перечисленного название концертного зала, а не стадиона ?", answers: ["«Камп Ноу»", "«Альберт-холл»", "«Сан-Сиро»", "«Энфилд»"], correctAnswer: 1),
        Question(question: "Что норвежцы дарят на Новый год в качестве символа тепла и счастья ?", answers: ["дрова", "свечи", "спички", "пледы"], correctAnswer: 2)
    ]
    
    var questionMode: QuestionMode = .consistently
    
    var currentQuestion: Question?
    
    var currentQuestionPos = 0
    var noCorrect = 0
    //var randomQuestions = 0
    
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
        if(idx == currentQuestion?.correctAnswer) {
            noCorrect += 1

            loadNextQuestion(createQuestionStrategy: chooseStrategy, questionMode: questionMode)
        } else {
            let percentRight = (Double(noCorrect) / Double(questions.count)) * 100

            let gameSession = GameSession(percentСorrectQuestions: Observable(percentRight), currentQuestionsNumber: Observable(noCorrect), numberResolvedIssues: noCorrect, numberQuestions: questions.count)
            GameSingleton.shared.addGameSession(session: gameSession)

            GameSingleton.shared.percentRight = percentRight

            onGameEnd?(noCorrect)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func loadNextQuestion(createQuestionStrategy: CreateQuestionStrategy, questionMode: QuestionMode) {
        createQuestionStrategy.currentQuestion = currentQuestion
        createQuestionStrategy.nextQuestion()
        setQuestion()
    }
    
    
    func setQuestion() {
        questionLabel.text = currentQuestion?.question
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.numberOfLines = 0
        
        let answers = [currentQuestion?.answers[0], currentQuestion?.answers[1], currentQuestion?.answers[2], currentQuestion?.answers[3]]
        
        zip(answerCollectionButton, answers).forEach { (answerCollectionButton, answer) in
            answerCollectionButton.setTitle(answer, for: .normal)
        }
        
        let percentRight = (Double(noCorrect) / Double(questions.count)) * 100
        let gameSession = GameSession(percentСorrectQuestions: Observable(percentRight), currentQuestionsNumber: Observable(noCorrect), numberResolvedIssues: noCorrect, numberQuestions: questions.count)
        
        percentСorrectQuestionsLabel.lineBreakMode = .byWordWrapping
        percentСorrectQuestionsLabel.numberOfLines = 0
        
        gameSession.percentСorrectQuestions.addObserver(self, options: [.new, .initial], closure: { [weak self] (percentСorrectQuestions, _) in
            self?.percentСorrectQuestionsLabel.text = "procent \(ceil(percentСorrectQuestions)) \n"
        })
        
        currentQuestionsNumberLabel.lineBreakMode = .byWordWrapping
        currentQuestionsNumberLabel.numberOfLines = 0
        
        gameSession.currentQuestionsNumber.addObserver(self, options: [.new, .initial], closure: { [weak self] (currentQuestionsNumber, _) in
            self?.currentQuestionsNumberLabel.text = "current questions \(currentQuestionsNumber)"
        })
    }
    
    var chooseStrategy: CreateQuestionStrategy {
        switch self.questionMode {
        case .consistently:
            return СonsecutiveQuestionsStrategy()
        case .randomly:
            return RandomQuestionsStrategy()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is MainViewController
        {
            let vc = segue.destination as? MainViewController
            vc?.mainVCDelegate = self
        }
    }
}
