//
//  Date+Extensions.swift
//  Posterr
//
//  Created by Anthony Apollo on 07/08/22.
//

import Foundation

extension Date {
    
    var formattedString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "US")
        formatter.dateFormat = "MMMM dd, yyyy"
        
        return formatter.string(from: self)
    }
    
    var day: String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "US")
        formatter.dateFormat = "dd"
        
        return formatter.string(from: self)
    }
    
}
