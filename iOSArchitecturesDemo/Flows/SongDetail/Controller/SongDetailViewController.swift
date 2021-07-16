//
//  SongDetailViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 09.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import AVFoundation
import UIKit

class SongDetailViewController: UIViewController {
     
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var currentTimeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var authorTitleLabel: UILabel!
    @IBOutlet weak var previousTrackButton: UIButton!
    @IBOutlet weak var playPauseTrackButton: UIButton!
    @IBOutlet weak var nextTrackButton: UIButton!
    @IBOutlet weak var volumeSlider: UISlider!

    var viewModel: PlaybackViewModel?
    
    init(selectIndex: Int, songs: [ITunesSong]) {
        viewModel = PlaybackViewModel(selectIndex: selectIndex, songs: songs)
        super.init(nibName: "SongDetailViewController", bundle: nil)
    }
    
    private func configureUI() {
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
        
        self.trackImageView.layer.cornerRadius = 10
    }
    
    private func bindViewModel() {
        viewModel?.imageView.addObserver(self, closure: { [weak self] (image, _) in
            DispatchQueue.main.async {
                self?.trackImageView.image = image
            }
        })
        
        viewModel?.currentTime.addObserver(self, closure: { [weak self] (value, _) in
            DispatchQueue.main.async {
                self?.currentTimeSlider.value = value
            }
        })
        
        viewModel?.currentTimeText.addObserver(self, closure: { [weak self] (value, _) in
            DispatchQueue.main.async {
                self?.currentTimeLabel.text = value
            }
        })
        
        viewModel?.durationTimeText.addObserver(self, closure: { [weak self] (value, _) in
            DispatchQueue.main.async {
                self?.durationTimeLabel.text = value
            }
        })
        
        viewModel?.trackTitleLabel.addObserver(self, closure: { [weak self] (value, _) in
            DispatchQueue.main.async {
                self?.trackTitleLabel.text = value
            }
        })
        
        viewModel?.authorTitleLabel.addObserver(self, closure: { [weak self] (value, _) in
            DispatchQueue.main.async {
                self?.authorTitleLabel.text = value
            }
        })
        
        viewModel?.playPauseTrackImage.addObserver(self, closure: { [weak self] (value, _) in
            DispatchQueue.main.async {
                self?.playPauseTrackButton.setImage(value, for: .normal)
            }
        })
        
        viewModel?.trackImageTransofrm.addObserver(self, closure: { [weak self] (value, _) in
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 1,
                           options: .curveEaseInOut,
                           animations: {
                                self?.trackImageView.transform = value
                           }, completion: nil)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.bindViewModel()
        
        viewModel?.setupPlayer()
    }
    
    @IBAction func playPayseAction(_ sender: UIButton) {
        viewModel?.playPause()
    }
    
    @IBAction func previousTrackAction(_ sender: UIButton) {
        viewModel?.previousTrack()
    }
    
    @IBAction func nextTrackAction(_ sender: UIButton) {
        viewModel?.nextTrack()
    }
    
    @IBAction func handleCurrentTimeSlider(_ sender: UISlider) {
        viewModel?.changeCurrentTime(position: sender.value)
    }
    
    @IBAction func handleVolumeSlider(_ sender: UISlider) {
        viewModel?.changeVolume(volume: sender.value)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
