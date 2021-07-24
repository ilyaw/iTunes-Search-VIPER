//
//  Nib.swift
//  iOSArchitecturesDemo
//
//  Created by Ilya on 15.07.2021.
//  Copyright © 2021 ekireev. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)![0] as! T
    }
}
