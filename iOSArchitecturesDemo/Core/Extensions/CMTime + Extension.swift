//
//  CMTime + Extension.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 16.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit
import AVKit

extension CMTime {
    
    func toDisplayString() -> String {
        guard !CMTimeGetSeconds(self).isNaN else { return "" }
        let totalSecond = Int(CMTimeGetSeconds(self))
        let seconds = totalSecond % 60
        let minutes = totalSecond / 60
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        return timeFormatString
    }
    
}
