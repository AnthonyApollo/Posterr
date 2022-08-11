//
//  PostCreationViewDelegateSpy.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 11/08/22.
//

@testable import Posterr

class PostCreationViewDelegateSpy: PostCreationViewDelegate {
    
    var pushedMessage: String?
    var pushedPost: Post?
    
    var isShouldUpdateTextViewCalled = false
    var isDidPostMessageCalled = false
    var isDidPostMessageWithPostCalled = false
    
    func shouldUpdateTextView(for: Int) -> Bool {
        isShouldUpdateTextViewCalled = true
        return true
    }
    
    func didPost(_ message: String) {
        pushedMessage = message
        isDidPostMessageCalled = true
    }
    
    func didPost(_ message: String, with post: Post) {
        pushedMessage = message
        pushedPost = post
        isDidPostMessageWithPostCalled = true
    }
    
}
