//
//  ComputerGameState.swift
//  XO-game
//
//  Created by Сергей Горячев on 17.01.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation
import GameplayKit

class ComputerGameState: GameState {
    
    
    var isMoveCompleted: Bool = false
    
    public let player: Player
    private let random = GKRandomSource.sharedRandom()
    weak var gameViewContoller: GameViewController?
    weak var gameBoard: Gameboard?
    weak var gameBoardView: GameboardView?
    private lazy var referee = Referee(gameboard: gameBoard!)
    
    let markViewPrototype: MarkView
    
    var turnsPerPlayer: Int {
        return Int(ceil(0.5 * Double(GameboardSize.columns * GameboardSize.rows)))
    }
    
    init(player: Player, gameViewContoller: GameViewController,
         gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameBoard = gameBoard
        self.gameViewContoller = gameViewContoller
        self.gameBoardView = gameBoardView
        
        self.markViewPrototype = markViewPrototype
    }
    
    func addSign(at position: GameboardPosition) {
        guard let gameBoardView = gameBoardView, gameBoardView.canPlaceMarkView(at: position) else { return }
        
        let markView: MarkView
        
//        switch player {
//        case .first:
//            markView = XView()
//        case .second:
//            markView = OView()
//        }
        
        Logger.shared.log(action: .playerSetSign(player: player, position: position))
        gameBoard?.setPlayer(player, at: position)
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position, animated: true)
        isMoveCompleted = true
    }
    
    func begin() {
        var positions = generateRandomWinningCombination()
            while positions.count < turnsPerPlayer {
              positions.append(generateRandomPosition())
            }
            positions = random.arrayByShufflingObjects(in: positions) as! [GameboardPosition]
        
        switch player {
        case .first:
            gameViewContoller?.firstPlayerTurnLabel.isHidden = false
            gameViewContoller?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewContoller?.firstPlayerTurnLabel.isHidden = true
            gameViewContoller?.secondPlayerTurnLabel.isHidden = false
        }
        
        gameViewContoller?.winnerLabel.isHidden = true
    }
    
    private func generateRandomWinningCombination() -> [GameboardPosition] {
        let index = random.nextInt(upperBound: referee.winningCombinations.count)
        return referee.winningCombinations[index]
      }

      private func generateRandomPosition() -> GameboardPosition {
        let column = random.nextInt(upperBound: GameboardSize.columns)
        let row = random.nextInt(upperBound: GameboardSize.rows)
        return GameboardPosition(column: column, row: row)
      }
}
