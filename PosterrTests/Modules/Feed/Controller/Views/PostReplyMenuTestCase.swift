//
//  PostReplyMenuTestCase.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import XCTest
import SnapshotTesting
@testable import Posterr

class PostReplyMenuTestCase: XCTestCase {
    
    var sut: PostReplyMenu!
    var delegateSpy: PostReplyMenuDelegateSpy!
    
    override func setUp() {
        delegateSpy = .init()
        sut = .init(with: delegateSpy)
        sut.frame = CGRect(x: 0, y: 0, width: 382, height: 80)
    }
    
    func test_PostReplyMenu_shouldMatchSnapshot() {
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_didTouchRepostButton_shouldCallDelegateDidTapRepost() {
        sut.didTouchRepostButton()
        
        XCTAssertTrue(delegateSpy.isDidTapRepostCalled)
    }
    
    func test_didTouchQuoteButton_shouldCallDelegateDidTapQuote() {
        sut.didTouchQuoteButton()
        
        XCTAssertTrue(delegateSpy.isDidTapQuoteCalled)
    }
    
}
