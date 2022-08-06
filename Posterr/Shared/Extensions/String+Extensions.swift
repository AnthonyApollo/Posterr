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
    
}
