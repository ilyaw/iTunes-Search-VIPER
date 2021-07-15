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
     
    @IBOutlet weak var trackImage: UIImageView!
    
    
    var player: AVAudioPlayer?
    var viewModel: PlaybackViewModel?
    
    init(selectIndex: Int, songs: [ITunesSong]) {
        
        print(songs[selectIndex].bigArtwork)
        
        viewModel = PlaybackViewModel(selectIndex: selectIndex, songs: songs)
        
    
        super.init(nibName: "SongDetailViewController", bundle: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
        
        viewModel?.playPause()
        
      
        
        
        
//        trackImage.image = UIImage(data: <#T##Data#>)
        
        
        //        let urlString = song.previewUrl
        
        
        //        let urlstring = song.previewUrl!
        //         let url = URL(string: urlstring)
        //         let data = try! Data(contentsOf: url!)
        //         player = try! AVAudioPlayer(data: data)
        //         player?.prepareToPlay()
        //         player?.volume = 1.0
        //         player?.play()
        
//        do {
//            
//            try AVAudioSession.sharedInstance().setMode(.default)
//            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
//            
//            if let urlString = songs[currentIndex].previewUrl,
//               let url = URL(string: urlString),
//               let data = try? Data(contentsOf: url)  {
//                player = try AVAudioPlayer(data: data)
//                
//                guard let player = player else { return }
//                
//                player.play()
//            }
//            
//        } catch {
//            print(error.localizedDescription)
//        }
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        viewModel.stop()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
