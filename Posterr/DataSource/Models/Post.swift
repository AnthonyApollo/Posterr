//
//  Post.swift
//  Posterr
//
//  Created by Anthony Apollo on 09/08/22.
//

import Foundation

final class Post: Equatable {
    
    let id: UUID
    let author: String
    let date: Date
    let message: String?
    let originalPost: Post?
    let quotePost: Post?
    
    init?(from dto: PostDTO?) {
        guard let dto = dto,
              let id = dto.id,
              let author = dto.author?.username,
              let date = dto.date else { return nil }
        
        self.id = id
        self.author = author
        self.date = date
        self.message = dto.message
        self.originalPost = Post(from: dto.originalPost)
        self.quotePost = Post(from: dto.quotePost)
    }
    
    init(id: UUID, author: String, date: Date, message: String?, originalPost: Post?, quotePost: Post?) {
        self.id = id
        self.author = author
        self.date = date
        self.message = message
        self.originalPost = originalPost
        self.quotePost = quotePost
    }
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        return lhs.id == rhs.id
    }
    
}
