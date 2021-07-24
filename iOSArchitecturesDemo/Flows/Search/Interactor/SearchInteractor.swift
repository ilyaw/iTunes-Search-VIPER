//
//  SearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 13.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import Alamofire

protocol SearchInteractorInput {
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void)
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void)
}

final class SearchInteractor: SearchInteractorInput {
    
    private let searchService = ITunesSearchService()
    
    func requestApps(with query: String, completion: @escaping (Result<[ITunesApp]>) -> Void) {
        
        if let cache = NetworkManager.cacheApps.object(forKey: query as NSString) as? [ITunesApp] {
            completion(.success(cache))
            return
        }
        
        self.searchService.getApps(forQuery: query, then: completion)
    }
    
    func requestSongs(with query: String, completion: @escaping (Result<[ITunesSong]>) -> Void) {
        
        if let cache = NetworkManager.cacheSongs.object(forKey: query as NSString) as? [ITunesSong] {
            completion(.success(cache))
            return
        }
        
        self.searchService.getSongs(forQuery: query, then: completion)
    }
}

