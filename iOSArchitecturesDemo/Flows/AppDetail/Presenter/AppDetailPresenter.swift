//
//  AppDetailPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 05.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

protocol AppDetailViewInput: AnyObject {
    var app: ITunesApp { get set }
}

protocol AppDetailViewOutput: AnyObject {
    func getSizeText(text: String) -> CGFloat
    func openAppInITunes(app: ITunesApp)
}

class AppDetailPresenter {
    
    private func height(text: String, font: UIFont) -> CGFloat {
        //20 * 2 - отсупы слева и справа
        let width =  UIScreen.main.bounds.width - 20 * 2
        
        let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
            
        let size = text.boundingRect(with: textSize,
                                     options: .usesLineFragmentOrigin,
                                     attributes: [NSAttributedString.Key.font : font],
                                     context: nil)
        
        return ceil(size.height)
    }
    
    private func openApp(_ app: ITunesApp) {
        guard let urlString = app.appUrl, let url = URL(string: urlString) else { return }
        
        UIApplication.shared.open(url, options: [:])
    }
}

extension AppDetailPresenter: AppDetailViewOutput {
    func getSizeText(text: String) -> CGFloat {
        return height(text: text, font: UIFont.systemFont(ofSize: 15))
    }
    
    func openAppInITunes(app: ITunesApp) {
        openApp(app)
    }
}
