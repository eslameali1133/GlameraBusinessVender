//
//  CardView.swift
//
//
//  Created by  on 3/8/17.
//  Copyright © 2017 approc. All rights reserved.
//

import UIKit

@IBDesignable
class CardView: UIView {
    
    @IBInspectable var _cornerRadius: CGFloat = 5
    @IBInspectable var shadowOffsetWidth: Int = 1
    @IBInspectable var shadowOffsetHeight: Int = 1
    @IBInspectable var _shadowColor: UIColor? = UIColor.black
    @IBInspectable var _shadowOpacity: Float = 0.2
    
    override func layoutSubviews() {
        layer.cornerRadius = _cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: _cornerRadius)
        layer.masksToBounds = false
        layer.shadowColor = _shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = _shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
}
