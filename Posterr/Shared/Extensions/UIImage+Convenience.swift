//
//  UIImage+Extensions.swift
//  Posterr
//
//  Created by Anthony Apollo on 08/08/22.
//

import UIKit

extension UIImage {
    
    static func fromSystem(named systemName: String) -> UIImage {
        return UIImage(systemName: systemName) ?? UIImage()
    }
    
}
