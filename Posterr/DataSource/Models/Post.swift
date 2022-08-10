//
//  Post.swift
//  Posterr
//
//  Created by Anthony Apollo on 09/08/22.
//

import Foundation

final class Post {
    
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
    
}
