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
        return .init(id: .init(uuidString: "517ffe63-7ad0-4f8f-bdde-b9a21ac448dd")!, author: "username", date: .distantPast, message: "This is a default post message ;)", originalPost: nil, quotePost: nil)
    }
    
    static func repostDummy() -> Post {
        return .init(id: .init(uuidString: "78bf6a49-b770-4d6b-bd5e-070fae125326")!, author: "reposter", date: .distantPast, message: nil, originalPost: .dummy(), quotePost: nil)
    }
    
    static func quotePostDummy() -> Post {
        return .init(id: .init(uuidString: "f519123f-8e2f-46e6-a11d-001c334df8bf")!, author: "quoter", date: .distantPast, message: "This is a default quoting message =)", originalPost: nil, quotePost: .dummy())
    }
    
}
