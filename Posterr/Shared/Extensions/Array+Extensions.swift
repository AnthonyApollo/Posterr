//
//  Array+Extensions.swift
//  Posterr
//
//  Created by Anthony Apollo on 04/08/22.
//

import Foundation

extension Array {
    
    subscript(safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }
    
}
