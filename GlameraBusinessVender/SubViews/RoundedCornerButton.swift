//
//  RoundedCornerButton.swift
//  
//
//  Created by  on 3/8/17.
//  Copyright © 2017 approc. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedCornerButton: UIButton {
    
    @IBInspectable var _cornerRadius: CGFloat = 5
    @IBInspectable var _borderWidth: CGFloat = 0.0
    @IBInspectable var _borderColor: UIColor? = UIColor.clear
    
    override func awakeFromNib() {
        // self.backgroundColor = .clear
        self.layer.cornerRadius = _cornerRadius
        self.layer.borderWidth = _borderWidth
        self.layer.borderColor = _borderColor?.cgColor
    }
}
