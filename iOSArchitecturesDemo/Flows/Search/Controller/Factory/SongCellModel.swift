//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 08.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Foundation

struct SongCellModel {
    let songTitle: String
    let authorTitle: String
    let albumTitle: String
    let coverPhoto: String?
}

final class SongCellModelFactory {
    
    static func cellModel(from model: ITunesSong) -> SongCellModel {
        return SongCellModel(songTitle: model.trackName,
                             authorTitle: model.artistName ?? "No name",
                             albumTitle: model.collectionName ?? "",
                             coverPhoto: model.trackImage)
    }
}
