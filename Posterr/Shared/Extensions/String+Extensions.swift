//
//  String+Extensions.swift
//  Posterr
//
//  Created by Anthony Apollo on 06/08/22.
//

extension String {
    
    var isBlankOrEmpty: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    var isValidUsername: Bool {
        return isAlphanumeric && count <= 14
    }
    
}
