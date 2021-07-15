//
//  PlaybackViewModel.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 15.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import AVKit
import UIKit

protocol PlaybackViewModelInput {
    func playPause()
    func nextTrack()
    func previousTrack()
    func changeVolume(volume: Float)
}

protocol PlaybackViewModelOutput {
    var onProgressViewChanged: ((Float) -> Void)? { get set}
}

class PlaybackViewModel: PlaybackViewModelOutput {
    
    private var currentIndex: Int
    private var songs: [ITunesSong]
    private let player: AVPlayer = {
       let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    
    
    var onProgressViewChanged: ((Float) -> Void)?
    
    init(selectIndex: Int, songs: [ITunesSong]) {
        self.currentIndex = selectIndex
        self.songs = songs

//        guard let url = URL(string: songs[selectIndex].previewUrl!) else { return }
//        let playerItem = AVPlayerItem(url: url)
//        player.replaceCurrentItem(with: playerItem)
//        player.play()
        
        
    }
}

extension PlaybackViewModel: PlaybackViewModelInput {
    
    func playPause() {
        
    }
    
    func nextTrack() {
        
    }
    
    func previousTrack() {
        
    }
    
    func changeVolume(volume: Float) {
        player.volume = volume
    }
    
   
    
}
