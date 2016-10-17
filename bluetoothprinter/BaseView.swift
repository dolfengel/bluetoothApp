//
//  BaseView.swift
//  bluetoothprinter
//
//  Created by Rui Caneira on 10/9/16.
//  Copyright © 2016 Rui Caneira. All rights reserved.
//

import UIKit

class BaseView: UIView {
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(colorLiteralRed: 0.7556, green: 0.7556, blue: 0.7556, alpha: 0.8).CGColor
    }
}
