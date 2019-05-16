//
//  RounderSegmented.swift
//  GlameraBusinessVender
//
//  Created by apple on 5/14/19.
//  Copyright © 2019 Glamera-Business. All rights reserved.
//

import UIKit

@IBDesignable
class RounderSegmented: UISegmentedControl {
    
    @IBInspectable var _cornerRadius: CGFloat = 5
//    @IBInspectable var borderWidth: Int = 3
//    @IBInspectable var _shadowColor: UIColor? = UIColor.black
//    @IBInspectable var _shadowOpacity: Float = 0.5
    
    override func awakeFromNib() {
        layer.cornerRadius = _cornerRadius
        //        layer.borderWidth = borderWidth
        //        layer.borderColor =
        layer.masksToBounds = false
    }
}
