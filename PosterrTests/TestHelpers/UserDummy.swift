//
//  UserDummy.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 09/08/22.
//

import Foundation
@testable import Posterr

extension User {
    
    static func dummy() -> User {
        return .init(username: "defaultUser2022", joinDate: .distantPast, posts: 10, reposts: 10, quotePosts: 10)
    }
    
    static func dummy2() -> User {
        return .init(username: "defaultUser2022", joinDate: .distantPast, posts: 20, reposts: 20, quotePosts: 20)
    }
    
}
