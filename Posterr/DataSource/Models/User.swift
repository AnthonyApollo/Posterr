//
//  User.swift
//  Posterr
//
//  Created by Anthony Apollo on 09/08/22.
//

import Foundation

struct User {
    
    let username: String
    let joinDate: Date
    let posts: Int
    let reposts: Int
    let quotePosts: Int
    
    init?(from dto: UserDTO) {
        guard let username = dto.username,
              let joinDate = dto.joinedDate else { return nil }
        
        self.username = username
        self.joinDate = joinDate
        self.posts = Int(dto.posts)
        self.reposts = Int(dto.reposts)
        self.quotePosts = Int(dto.quotePosts)
    }
    
    init(username: String, joinDate: Date, posts: Int, reposts: Int, quotePosts: Int) {
        self.username = username
        self.joinDate = joinDate
        self.posts = posts
        self.reposts = reposts
        self.quotePosts = quotePosts
    }
    
}
