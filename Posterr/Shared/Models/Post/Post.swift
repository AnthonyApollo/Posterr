//
//  Post.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import Foundation

struct Post: Codable, Identifiable {
    
    let id: Int
    
    let author: User
    let message: String?
    let originalPostID: Int?
    let quotePostID: Int?
    
    init(id: Int, author: User, message: String? = nil, originalPostID: Int? = nil, quotePostID: Int? = nil) {
        self.id = id
        self.author = author
        self.message = message
        self.originalPostID = originalPostID
        self.quotePostID = quotePostID
    }
    
}

extension Post {
    
    static func dummy() -> Post {
        .init(id: 1, author: .dummy(), message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque in massa tortor. Integer viverra, arcu rhoncus molestie consequat, velit elit ullamcorper urna, ut pulvinar nisi lacus sit amet nisl.")
    }
    
    static func dummies() -> [Post] {
        [.dummy(), .dummy(), .dummy()]
    }
    
}
