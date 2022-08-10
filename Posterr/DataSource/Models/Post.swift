//
//  Post.swift
//  Posterr
//
//  Created by Anthony Apollo on 09/08/22.
//

import Foundation

final class DomainPost {
    
    let id: UUID
    let author: String
    let date: Date
    let message: String?
    let originalPost: DomainPost?
    let quotePost: DomainPost?
    
    init?(from dto: Post?) {
        guard let dto = dto,
              let id = dto.id,
              let author = dto.author?.username,
              let date = dto.date else { return nil }
        
        self.id = id
        self.author = author
        self.date = date
        self.message = dto.message
        self.originalPost = DomainPost(from: dto.originalPost)
        self.quotePost = DomainPost(from: dto.quotePost)
    }
    
}
