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
    func setupPlayer()
    func changeCurrentTime(position: Float)
    func playPause()
    func previousTrack()
    func nextTrack()
    func changeVolume(volume: Float)
}

protocol PlaybackViewModelOutput {
    var imageView: Observable<UIImage?> { get }
    var playPauseTrackImage: Observable<UIImage?> { get }
    var trackImageTransofrm: Observable<CGAffineTransform> { get }
    var currentTime: Observable<Float> { get }
    var currentTimeText: Observable<String> { get }
    var durationTimeText: Observable<String> { get }
    var trackTitleLabel: Observable<String> { get }
    var authorTitleLabel: Observable<String> { get }
}

class PlaybackViewModel: PlaybackViewModelOutput {

    var imageView = Observable<UIImage?>(nil)
    var playPauseTrackImage = Observable<UIImage?>(nil)
    var trackImageTransofrm = Observable<CGAffineTransform>(.identity)
    var currentTime = Observable<Float>(0.0)
    var currentTimeText = Observable<String>("")
    var durationTimeText = Observable<String>("")
    var trackTitleLabel = Observable<String>("")
    var authorTitleLabel = Observable<String>("")
    
    private var currentIndex: Int
    private let songs: [ITunesSong]
    private let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = false
        return avPlayer
    }()
    private let scale: CGFloat = 0.8
    
    private var currentSong: ITunesSong {
        return songs[currentIndex]
    }
    
    init(selectIndex: Int, songs: [ITunesSong]) {
        self.currentIndex = selectIndex
        self.songs = songs
    }
}

extension PlaybackViewModel: PlaybackViewModelInput {
 
    func setupPlayer() {
        self.setTrackImage()
        self.setTrackToPlayer()
        self.setObservablePlayer()
        self.setElementsOfSong()
    }
    
    private func setTrackImage() {
        guard let urlString = currentSong.bigArtwork else {
            return
        }
        
        ImageDownloader.getImage(fromUrl: urlString) { [weak self] (image, _) in
            if let image = image {
                self?.imageView.value = image
            } else {
                self?.imageView.value = UIImage(named: "noImage")
            }
        }
    }
    
    private func setTrackToPlayer() {
        guard let urlString = currentSong.previewUrl,
              let url = URL(string:urlString) else { return }
        
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    private func setObservablePlayer() {
        let interval = CMTimeMake(value: 1, timescale: 1)
        
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            self?.currentTimeText.value = time.toDisplayString()
            
            let durationTime = self?.player.currentItem?.duration
            let currentDurationText = ((durationTime ?? CMTimeMake(value: 1, timescale: 1)) - time).toDisplayString()
            self?.durationTimeText.value = "-\(currentDurationText)"
            self?.updateCurrentTimeSlider()
        }
    }
    
    private func setElementsOfSong() {
        trackTitleLabel.value = currentSong.trackName
        authorTitleLabel.value = currentSong.artistName ?? "No name"
        
        playPauseTrackImage.value = UIImage(named: "pause")
        trackImageTransofrm.value = .identity
    }
    
    private func updateCurrentTimeSlider() {
        let currentTimeSeconds = CMTimeGetSeconds(player.currentTime())
        let durationSeconds = CMTimeGetSeconds(player.currentItem?.duration ?? CMTimeMake(value: 1, timescale: 1))
        let percentage = currentTimeSeconds / durationSeconds
        self.currentTime.value = Float(percentage)

        if currentTime.value == 1.0 {
            nextTrack()
        }
    }
    
    func changeCurrentTime(position: Float) {
        let percentage = position
        guard let duration = player.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeUnSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeUnSeconds, preferredTimescale: 1)
        player.seek(to: seekTime)
    }
    
    func playPause() {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseTrackImage.value = UIImage(named: "pause")
            trackImageTransofrm.value = .identity
        } else {
            player.pause()
            playPauseTrackImage.value = UIImage(named: "play")
            trackImageTransofrm.value = CGAffineTransform(scaleX: scale, y: scale)
        }
    }
    
    func previousTrack() {
        if currentIndex - 1 < 0 {
            currentIndex = songs.count
        }
        
        currentIndex -= 1
        setupPlayer()
    }
    
    func nextTrack() {
        if currentIndex + 1 >= songs.count {
            currentIndex = -1
        }
     
        currentIndex += 1
        setupPlayer()
    }

    func changeVolume(volume: Float) {
        player.volume = volume
    }
}
