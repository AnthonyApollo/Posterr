//
//  PostTableViewCellTestCase.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import XCTest
import SnapshotTesting
@testable import Posterr

class PostTableViewCellTestCase: XCTestCase {
    
    var sut: PostTableViewCell!
    var delegateSpy: PostTableViewCellDelegateSpy!
    
    override func setUp() {
        super.setUp()
        delegateSpy = .init()
        
        sut = .init()
        
        sut.delegate = delegateSpy
        sut.frame = CGRect(x: 0, y: 0, width: 382, height: 150)
    }
    
    func test_PostTableViewCell_withPost_shouldMatchSnapshot() {
        sut.setup(with: .dummy())
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_didTapRepost_withPost_shouldCallDelegateDidTapRepost() throws {
        let expectedPost: Post = .dummy()
        
        sut.setup(with: .dummy())
        sut.didTapRepost()
        
        let actualPost = try XCTUnwrap(delegateSpy.pushedPost)
        XCTAssertEqual(expectedPost, actualPost)
        XCTAssertTrue(delegateSpy.isDidTapRepostCalled)
    }
    
    func test_didTapRepost_withoutPost_shouldReturn() throws {
        sut.didTapRepost()
        
        XCTAssertNil(delegateSpy.pushedPost)
        XCTAssertFalse(delegateSpy.isDidTapRepostCalled)
    }
    
    func test_didTapQuote_withPost_shouldCallDelegateDidTapQuote() throws {
        let expectedPost: Post = .dummy()
        
        sut.setup(with: .dummy())
        sut.didTapQuote()
        
        let actualPost = try XCTUnwrap(delegateSpy.pushedPost)
        XCTAssertEqual(expectedPost, actualPost)
        XCTAssertTrue(delegateSpy.isDidTapQuoteCalled)
    }
    
    func test_didTapQuote_withoutPost_shouldReturn() throws {
        sut.didTapQuote()
        
        XCTAssertNil(delegateSpy.pushedPost)
        XCTAssertFalse(delegateSpy.isDidTapQuoteCalled)
    }
    
}
