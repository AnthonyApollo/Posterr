//
//  UserProfileViewTestCase.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import XCTest
import SnapshotTesting
@testable import Posterr

class UserProfileViewTestCase: XCTestCase {
    
    var sut: UserProfileView!
    var feedRouterStub: FeedRouterStub!
    
    override func setUp() {
        super.setUp()
        
        feedRouterStub = .init()
        
        sut = .init(user: .dummy(), feedRouter: feedRouterStub)
        
        sut.frame = CGRect(x: 0, y: 0, width: 382, height: 900)
    }
    
    func test_UserProfileView_withUser_shouldMatchSnapshot() {
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_updateFeed_shouldMatchSnapshot() {
        sut.updateFeed()
        
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_updateUserInfo_withUser_shouldMatchSnapshot() {
        sut.updateUserInfo(with: .dummy2())
        
        assertSnapshot(matching: sut, as: .image)
    }
    
}
