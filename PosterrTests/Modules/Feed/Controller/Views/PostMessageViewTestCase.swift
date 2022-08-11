//
//  PostMessageViewTestCase.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import XCTest
import SnapshotTesting
@testable import Posterr

class PostMessageViewTestCase: XCTestCase {
    
    var sut: PostMessageView!
    var delegateSpy: PostMessageViewDelegateSpy!
    
    func test_PostMessageView_withPostType_shouldMatchSnapshot() {
        sut = .init(type: .post)
        sut.frame = CGRect(x: 0, y: 0, width: 382, height: 80)
        sut.setup(with: .dummy())
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_PostMessageView_withRepostType_shouldMatchSnapshot() {
        sut = .init(type: .repost)
        sut.frame = CGRect(x: 0, y: 0, width: 382, height: 80)
        sut.setup(with: .repostDummy())
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_PostMessageView_withQuotePostType_shouldMatchSnapshot() {
        sut = .init(type: .quotePost)
        sut.frame = CGRect(x: 0, y: 0, width: 382, height: 80)
        sut.setup(with: .quotePostDummy())
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_PostMessageView_withQuotePostTypeAndCloseButton_shouldMatchSnapshot() {
        sut = .init(type: .quotePost, shouldDisplayCloseButton: true)
        sut.frame = CGRect(x: 0, y: 0, width: 382, height: 80)
        sut.setup(with: .quotePostDummy())
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_didTouchCloseButton_shouldCallDelegateDidTouchCloseButton() {
        delegateSpy = .init()
        sut = .init(type: .post, delegate: delegateSpy)
        
        sut.didTouchCloseButton()
        
        XCTAssertTrue(delegateSpy.isDidTouchCloseButtonCalled)
    }
    
}
