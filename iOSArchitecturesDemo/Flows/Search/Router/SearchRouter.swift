//
//  SearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 13.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol SearchRouterInput {
    func openDetails(for app: ITunesApp)
    func openAppInITunes(_ app: ITunesApp)
//    func openSongDetails(for song: ITunesSong)
    func openSongDetails(for index: Int, songs: [ITunesSong])
}

class SearchRouter: SearchRouterInput {

    weak var viewController: UIViewController?
    
    func openDetails(for app: ITunesApp) {
        let appDetailVC = AppDetailViewController(app: app)
        
        viewController?.navigationController?.pushViewController(appDetailVC, animated: true)
    }
    
    func openAppInITunes(_ app: ITunesApp) {
        guard let urlString = app.appUrl, let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url, options: [:])
    }
    
    func openSongDetails(for index: Int, songs: [ITunesSong]) {
        let songDetailVC = SongDetailViewController(selectIndex: index, songs: songs)
        
        viewController?.navigationController?.pushViewController(songDetailVC, animated: true)
    }
    
//    func openSongDetails(for song: ITunesSong) {
//        let songDetailVC = SongDetailViewController(song: song)
//
//        viewController?.navigationController?.pushViewController(songDetailVC, animated: true)
//    }
    
}
