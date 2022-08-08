//
//  UIStackView+Extensions.swift
//  Posterr
//
//  Created by Anthony Apollo on 08/08/22.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ subviews: UIView...) {
        subviews.forEach(addArrangedSubview)
    }
    
}
