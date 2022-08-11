//
//  UserInfoViewTestCase.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 09/08/22.
//

import XCTest
import SnapshotTesting
@testable import Posterr

class UserInfoViewTestCase: XCTestCase {
    
    var sut: UserInfoView!
    
    override func setUp() {
        super.setUp()
        sut = .init(user: .dummy())
        sut.frame = CGRect(x: 0, y: 0, width: 382, height: 150)
    }
    
    func test_UserInfoView_withUser_shouldMatchSnapshot() {
        assertSnapshot(matching: sut, as: .image)
    }
    
    func test_update_withUser_shouldMatchSnapshot() {
        sut.update(with: .dummy2())
        
        assertSnapshot(matching: sut, as: .image)
    }
    
}
