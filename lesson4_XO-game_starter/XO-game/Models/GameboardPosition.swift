//
//  GameBoardPosition.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public struct GameboardPosition: Hashable {
    
    public let column: Int
    public let row: Int
    
    public var randomPlaceRow = Int.random(in: 0...2)
    public var randomPlaceCol = Int.random(in: 0...2)
}
