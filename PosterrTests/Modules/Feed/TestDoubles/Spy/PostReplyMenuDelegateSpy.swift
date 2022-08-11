//
//  PostReplyMenuDelegateSpy.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

@testable import Posterr

class PostReplyMenuDelegateSpy: PostReplyMenuDelegate {
    
    var isDidTapRepostCalled = false
    var isDidTapQuoteCalled = false
    
    func didTapRepost() {
        isDidTapRepostCalled = true
    }
    
    func didTapQuote() {
        isDidTapQuoteCalled = true
    }
    
}
