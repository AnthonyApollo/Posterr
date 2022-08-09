//
//  UITextView+Extensions.swift
//  Posterr
//
//  Created by Anthony Apollo on 05/08/22.
//

import UIKit

extension UITextView {
    
    func clear() {
        text = ""
        resignFirstResponder()
    }
    
}
