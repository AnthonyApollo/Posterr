//
//  PostCreationViewTestCase.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 11/08/22.
//

import XCTest
import SnapshotTesting
@testable import Posterr

class PostCreationViewTestCase: XCTestCase {
    
    var sut: PostCreationView!
    var delegateSpy: PostCreationViewDelegateSpy!
    
    override func setUp() {
        super.setUp()
        
        delegateSpy = .init()
        
        sut = .init()
        sut.delegate = delegateSpy
        sut.frame = CGRect(x: 0, y: 0, width: 382, height: 185)
    }
    
    func test_PostCreationView_shouldMatchSnapshot() {
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_PostCreationView_withText_shouldMatchSnapshot() {
        sut.textView.text = "New Post"
        sut.enablePostButton()
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_PostCreationView_withTextAndQuote_shouldMatchSnapshot() {
        sut.textView.text = "New Post"
        sut.enablePostButton()
        sut.setupQuote(of: .quotePostDummy())
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_updateRemainingCharacters_withCount_shouldMatchSnapshot() {
        sut.updateRemainingCharacters(with: "776")
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_enablePostButton_shouldMatchSnapshot() {
        sut.enablePostButton()
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_disablePostButton_shouldMatchSnapshot() {
        sut.enablePostButton()
        sut.disablePostButton()
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_didTouchPostButton_withoutText_shouldReturn() {
        sut.didTouchPostButton()
        
        XCTAssertNil(delegateSpy.pushedMessage)
        XCTAssertNil(delegateSpy.pushedPost)
        XCTAssertFalse(delegateSpy.isDidPostMessageCalled)
        XCTAssertFalse(delegateSpy.isDidPostMessageWithPostCalled)
        XCTAssertFalse(delegateSpy.isShouldUpdateTextViewCalled)
    }
    
    func test_didTouchPostButton_withBlankText_shouldReturn() {
        sut.textView.text = " "
        sut.didTouchPostButton()
        
        XCTAssertNil(delegateSpy.pushedMessage)
        XCTAssertNil(delegateSpy.pushedPost)
        XCTAssertFalse(delegateSpy.isDidPostMessageCalled)
        XCTAssertFalse(delegateSpy.isDidPostMessageWithPostCalled)
        XCTAssertFalse(delegateSpy.isShouldUpdateTextViewCalled)
    }
    
    func test_didTouchPostButton_withText_shouldCallDelegatePost() throws {
        let expectedTextAfterPost = ""
        let expectedMessage = "New Post"
        
        sut.textView.text = expectedMessage
        sut.didTouchPostButton()
    
        let actualTextAfterPost = sut.textView.text
        let actualMessage = try XCTUnwrap(delegateSpy.pushedMessage)
        XCTAssertEqual(expectedMessage, actualMessage)
        XCTAssertEqual(expectedTextAfterPost, actualTextAfterPost)
        XCTAssertTrue(delegateSpy.isDidPostMessageCalled)
    }
    
    func test_post_withMessage_shouldCallDelegatePost() throws {
        let expectedMessage = "New Post"
        
        sut.post(message: expectedMessage)
    
        let actualMessage = try XCTUnwrap(delegateSpy.pushedMessage)
        XCTAssertEqual(expectedMessage, actualMessage)
        XCTAssertTrue(delegateSpy.isDidPostMessageCalled)
    }
    
    func test_post_withMessageAndQuote_shouldCallDelegatePostMessageWithPost() throws {
        let expectedMessage = "New Post"
        let expectedPost = Post.quotePostDummy()
        
        sut.setupQuote(of: expectedPost)
        sut.post(message: expectedMessage)
    
        let actualMessage = try XCTUnwrap(delegateSpy.pushedMessage)
        let actualPost = try XCTUnwrap(delegateSpy.pushedPost)
        XCTAssertEqual(expectedMessage, actualMessage)
        XCTAssertEqual(expectedPost, actualPost)
        XCTAssertTrue(delegateSpy.isDidPostMessageWithPostCalled)
    }
    
    func test_textView_withRangeAndText_shouldCallDelegateShouldUpdateTextView() {
        let shouldChange = sut.textView(sut.textView, shouldChangeTextIn: .init(), replacementText: "Message")
        
        XCTAssertTrue(shouldChange)
        XCTAssertTrue(delegateSpy.isShouldUpdateTextViewCalled)
    }
    
    func test_textView_withoutDelegate_shouldReturnFalse() {
        sut.delegate = nil
        
        let shouldChange = sut.textView(sut.textView, shouldChangeTextIn: .init(), replacementText: "Message")
        
        XCTAssertFalse(shouldChange)
    }
    
    func test_didTouchCloseButton_shouldMatchSnapshot() {
        sut.setupQuote(of: .dummy())
        sut.didTouchCloseButton()
        
        assertSnapshot(matching: sut, as: .image)
    }
    
}
