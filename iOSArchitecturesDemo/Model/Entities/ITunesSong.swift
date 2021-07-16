//
//  ITunesSong.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

public struct ITunesSong: Codable {
    
    public var trackName: String
    public var artistName: String?
    public var collectionName: String?
    public var trackImage: String?
    public var previewUrl: String?
    
    public var bigArtwork: String? {
        return trackImage?.replacingOccurrences(of: "60x60", with: "600x600")
    }
    
    // MARK: - Codable
    
    private enum CodingKeys: String, CodingKey {
        case trackName = "trackName"
        case artistName = "artistName"
        case collectionName = "collectionName"
        case trackImage = "artworkUrl60"
//        case bigArtwork = "artworkUrl100"
        case previewUrl = "previewUrl"
    }
    
    // MARK: - Init
    
    internal init(trackName: String,
                  artistName: String?,
                  collectionName: String?,
                  smallArtwork: String?,
//                  bigArtwork: String?,
                  previewUrl: String?) {
        self.trackName = trackName
        self.artistName = artistName
        self.collectionName = collectionName
        self.trackImage = smallArtwork
//        self.bigArtwork = bigArtwork
        self.previewUrl = previewUrl
    }
}
