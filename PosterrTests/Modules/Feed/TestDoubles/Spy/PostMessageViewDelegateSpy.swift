//
//  PostMessageViewDelegateSpy.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

@testable import Posterr

class PostMessageViewDelegateSpy: PostMessageViewDelegate {
    
    var isDidTouchCloseButtonCalled = false
    
    func didTouchCloseButton() {
        isDidTouchCloseButtonCalled = true
    }
    
}
