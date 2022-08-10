//
//  PostCountViewTestCase.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 09/08/22.
//

import XCTest
import SnapshotTesting
@testable import Posterr

class PostCountViewTestCase: XCTestCase {
    
    var sut: PostCountView!
    
    func test_PostCountView_withPostType_shouldMatchSnapshot() {
        sut = .init(user: .dummy(), type: .post)
        sut.frame = CGRect(x: 0, y: 0, width: 50, height: 24)
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_PostCountView_withRepostType_shouldMatchSnapshot() {
        sut = .init(user: .dummy(), type: .repost)
        sut.frame = CGRect(x: 0, y: 0, width: 50, height: 24)
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_PostCountView_withQuotePostType_shouldMatchSnapshot() {
        sut = .init(user: .dummy(), type: .quotePost)
        sut.frame = CGRect(x: 0, y: 0, width: 50, height: 24)
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_update_withUser_shouldMatchSnapshot() {
        sut = .init(user: .dummy(), type: .post)
        sut.frame = CGRect(x: 0, y: 0, width: 60, height: 24)
        
        sut.update(with: .dummy2())
        
        assertSnapshot(matching: sut, as: .image)
    }
    
}
