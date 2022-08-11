//
//  PostTableViewCellDelegateSpy.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

@testable import Posterr

class PostTableViewCellDelegateSpy: PostTableViewCellDelegate {
    
    var pushedPost: Post?
    
    var isDidTapRepostCalled = false
    var isDidTapQuoteCalled = false
    
    func didTapRepost(for post: Post) {
        pushedPost = post
        isDidTapRepostCalled = true
    }
    
    func didTapQuote(for post: Post) {
        pushedPost = post
        isDidTapQuoteCalled = true
    }
    
}
