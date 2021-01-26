//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Сергей Горячев on 26.01.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class PlayerInputState: GameState {
    
    var isMoveCompleted: Bool = false
    
    public let player: Player
    weak var gameViewContoller: GameViewController?
    weak var gameBoard: Gameboard?
    weak var gameBoardView: GameboardView?
    
    let markViewPrototype: MarkView
    
    lazy var movesForPlayerInput = [player: [MoveCommand]()]
    
    public var movesForPlayer: [Player: [MoveCommand]] {
        get { return movesForPlayerInput }
        set { movesForPlayerInput = newValue }
    }
    
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
    
    private func enqueueMoveCommand(at position: GameboardPosition) {
        guard let gameBoard = gameBoard, let gameBoardView = gameBoardView else { return }
        let newMove = MoveCommand(
            gameBoard: gameBoard,
            gameBoardView: gameBoardView,
            player: player,
            position: position
        )
        movesForPlayer[player]!.append(newMove)
    }
    
    func addSign(at position: GameboardPosition) {
        guard let gameBoardView = gameBoardView, gameBoardView.canPlaceMarkView(at: position) else { return }
        
        let moveCount = movesForPlayer[player]!.count
        guard moveCount < turnsPerPlayer else { return }
        displayMarkView(at: position, turnNumber: moveCount + 1)
        enqueueMoveCommand(at: position)
        
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
    
    private func displayMarkView(at position: GameboardPosition, turnNumber: Int) {
        guard let markView = gameBoardView?.markViewForPosition[position] else {
            let markView = player.markViewPrototype.copy() as MarkView
            markView.turnNumbers = [turnNumber]
            gameBoardView?.placeMarkView(markView, at: position, animated: false)
            return
        }
        markView.turnNumbers.append(turnNumber)
    }
    
    public func handleActionPressed() {
        guard movesForPlayer[player]!.count == turnsPerPlayer else { return }
        gameViewContoller?.nextPlayerTurn()
    }
    
    public func handleUndoPressed() {
        var moves = movesForPlayer[player]!
        guard let position = moves.popLast()?.position else { return }
        movesForPlayer[player] = moves
        
        let markView = gameBoardView?.markViewForPosition[position]!
        _ = markView?.turnNumbers.popLast()
        
        guard markView?.turnNumbers.count == 0 else { return }
        gameBoardView?.removeMarkView(at: position)
    }
    
}
