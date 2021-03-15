//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Сергей Горячев on 03.03.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

struct SongCellModel {
    let title: String
    let subtitle: String?
    let collection: String?
    let imageSong: String?
}

final class SongCellModelFactory {
    
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(title: model.trackName,
                            subtitle: model.artistName,
                            collection: model.collectionName,
                            imageSong: model.artwork)
    }
}
