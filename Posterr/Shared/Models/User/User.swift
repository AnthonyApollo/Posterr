//
//  User.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import Foundation

struct User: Codable, Identifiable {

    let id: Int
    let username: String
    let joinDate: Date
    let postCount: Int
    let repostCount: Int
    let quotePostCount: Int

}

extension User {

    static func dummy() -> User {
        .init(id: 1, username: "arthurMorgan72", joinDate: .init(), postCount: 10, repostCount: 11, quotePostCount: 12)
    }

}
