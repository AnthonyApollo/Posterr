//
//  DomainUser.swift
//  Posterr
//
//  Created by Anthony Apollo on 09/08/22.
//

import Foundation

struct DomainUser {
    
    let username: String
    let joinDate: Date
    var posts: Int
    var reposts: Int
    var quotePosts: Int
    
    var dto: User?
    
    init?(from dto: User) {
        guard let username = dto.username,
              let joinDate = dto.joinedDate else { return nil }
        
        self.username = username
        self.joinDate = joinDate
        self.posts = 0
        self.reposts = 0
        self.quotePosts = 0
        
        self.dto = dto
    }
    
}
