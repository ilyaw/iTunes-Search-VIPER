//
//  SongDetailView.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 09.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

class SongDetailView: UIView {
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        self.configureUI()
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureUI()
    }
//
    private func configureUI() {
        backgroundColor = .white
    }
}
