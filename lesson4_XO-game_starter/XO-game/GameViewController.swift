//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    private var counter: Int = 0
    private let gameBoard = Gameboard()
    private lazy var referee = Referee(gameboard: gameBoard)
    
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //первый делает ход
        if(pOrC == 1) {
            firstPlayerComputerTurn()
            
            gameboardView.onSelectPosition = { [weak self] position in
                guard let self = self else { return }
                
                self.currentState.addSign(at: position)
                self.counter += 1
                
                if self.currentState.isMoveCompleted {
                    self.nextPlayerComputerTurn()
                }
            }
        }
        
        //первый делает ход
        if(pOrC == 2) {
            firstPlayerTurn()
            
            gameboardView.onSelectPosition = { [weak self] position in
                guard let self = self else { return }
                
                self.currentState.addSign(at: position)
                self.counter += 1
                
                if self.currentState.isMoveCompleted {
                    self.nextPlayerTurn()
                }
            }
        }
    }
    
    private func firstPlayerTurn() {
        let firstPlayer: Player = .first
        currentState = PlayerInputState(player: firstPlayer, gameViewContoller: self,
                                       gameBoard: gameBoard,
                                       gameBoardView: gameboardView, markViewPrototype: firstPlayer.markViewPrototype)
    }
    
    func nextPlayerTurn() {
        if let winner = referee.determineWinner() {
            currentState = GameEndState(winnerPlayer: winner, gameViewController: self)
            Logger.shared.log(action: .gameFinished(winned: winner))
            return
        }
        
        if counter >= 9 {
            Logger.shared.log(action: .gameFinished(winned: nil))
            currentState = GameEndState(winnerPlayer: nil, gameViewController: self)
        }
        
        if let playerState = currentState as? PlayerGameState {
            let nextPlayer = playerState.player.next
            currentState = PlayerInputState(player: nextPlayer,
                                           gameViewContoller: self,
                                           gameBoard: gameBoard, gameBoardView: gameboardView,
                                           markViewPrototype: nextPlayer.markViewPrototype)
        }
    }
    
    private func firstPlayerComputerTurn() {
        let firstPlayer: Player = .first
        currentState = ComputerGameState(player: firstPlayer, gameViewContoller: self,
                                         gameBoard: gameBoard,
                                         gameBoardView: gameboardView, markViewPrototype: firstPlayer.markViewPrototype)
    }
    
    private func nextPlayerComputerTurn() {
        if let winner = referee.determineWinner() {
            currentState = GameEndState(winnerPlayer: winner, gameViewController: self)
            Logger.shared.log(action: .gameFinished(winned: winner))
            return
        }
        
        if counter >= 9 {
            Logger.shared.log(action: .gameFinished(winned: nil))
            currentState = GameEndState(winnerPlayer: nil, gameViewController: self)
        }
        
        if let playerState = currentState as? ComputerGameState {
            let nextPlayer = playerState.player.next
            currentState = ComputerGameState(player: nextPlayer,
                                           gameViewContoller: self,
                                           gameBoard: gameBoard, gameBoardView: gameboardView,
                                           markViewPrototype: nextPlayer.markViewPrototype)
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Logger.shared.log(action: .restartGame)
        
        gameboardView.clear()
        gameBoard.clear()
        counter = 0
        
        if(pOrC == 2) {
            firstPlayerTurn()
        }
        
        if(pOrC == 1) {
            firstPlayerComputerTurn()
        }
    }
}

