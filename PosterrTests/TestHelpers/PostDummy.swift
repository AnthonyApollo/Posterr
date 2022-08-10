//
//  PostDummy.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import Foundation
@testable import Posterr

extension Post {
    
    static func dummy() -> Post {
        return .init(id: UUID(), author: "username", date: .distantPast, message: "This is a default post message ;)", originalPost: nil, quotePost: nil)
    }
    
    static func repostDummy() -> Post {
        return .init(id: UUID(), author: "reposter", date: .distantPast, message: nil, originalPost: .dummy(), quotePost: nil)
    }
    
    static func quotePostDummy() -> Post {
        return .init(id: .init(), author: "quoter", date: .distantPast, message: "This is a default quoting message =)", originalPost: nil, quotePost: .dummy())
    }
    
}
