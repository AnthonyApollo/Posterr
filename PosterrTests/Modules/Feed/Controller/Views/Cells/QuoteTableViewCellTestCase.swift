//
//  QuoteTableViewCellTestCase.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import XCTest
import SnapshotTesting
@testable import Posterr

class QuoteTableViewCellTestCase: XCTestCase {
    
    var sut: QuoteTableViewCell!
    var delegateSpy: PostTableViewCellDelegateSpy!
    
    override func setUp() {
        delegateSpy = .init()
        
        sut = .init()
        
        sut.delegate = delegateSpy
        sut.frame = CGRect(x: 0, y: 0, width: 382, height: 230)
    }
    
    func test_QuoteTableViewCell_withQuotePost_shouldMatchSnapshot() {
        sut.setup(with: .quotePostDummy())
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_QuoteTableViewCell_withPost_shouldMatchSnapshot() {
        sut.setup(with: .dummy())
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_didTapRepost_withPost_shouldCallDelegateDidTapRepost() throws {
        let expectedPost: Post = .quotePostDummy()
        
        sut.setup(with: .quotePostDummy())
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
        let expectedPost: Post = .quotePostDummy()
        
        sut.setup(with: .quotePostDummy())
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
