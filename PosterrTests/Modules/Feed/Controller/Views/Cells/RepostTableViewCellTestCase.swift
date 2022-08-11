//
//  RepostTableViewCellTestCase.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import XCTest
import SnapshotTesting
@testable import Posterr

class RepostTableViewCellTestCase: XCTestCase {
    
    var sut: RepostTableViewCell!
    var delegateSpy: PostTableViewCellDelegateSpy!
    
    override func setUp() {
        delegateSpy = .init()
        
        sut = .init()
        
        sut.delegate = delegateSpy
        sut.frame = CGRect(x: 0, y: 0, width: 382, height: 200)
    }
    
    func test_RepostTableViewCell_withPost_shouldMatchSnapshot() {
        sut.setup(with: .repostDummy())
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_didTapRepost_withPost_shouldCallDelegateDidTapRepost() throws {
        let expectedPost: Post = .repostDummy()
        
        sut.setup(with: .repostDummy())
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
        let expectedPost: Post = .repostDummy()
        
        sut.setup(with: .repostDummy())
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
