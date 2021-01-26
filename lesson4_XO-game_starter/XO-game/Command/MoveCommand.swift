//
//  MoveCommand.swift
//  XO-game
//
//  Created by Сергей Горячев on 26.01.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

public struct MoveCommand {
    public var gameBoard: Gameboard
    public var gameBoardView: GameboardView
    public var player: Player
    public var position: GameboardPosition
    
    public func execute(completion: (() -> Void)? = nil) {
        gameBoard.setPlayer(player, at: position)
        gameBoardView.placeMarkView(player.markViewPrototype.copy(), at: position, animated: true, completion: completion)
    }
}
