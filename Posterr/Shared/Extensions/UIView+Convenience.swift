//
//  UIView+Extensions.swift
//  Posterr
//
//  Created by Anthony Apollo on 04/08/22.
//

import UIKit

extension UIView {
    
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }
    
    func setLightShadow() {
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 5
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
    
    func setThinBorder() {
        layer.cornerRadius = 5
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.separator.cgColor
    }
    
}
