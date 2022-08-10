//
//  UserProfileViewControllerTestCase.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import XCTest
@testable import Posterr

class UserProfileViewControllerTestCase: XCTestCase {
    
    var sut: UserProfileViewController!
    var presenterSpy: UserProfilePresenterSpy!
    var routerStub: FeedRouterStub!
    var viewSpy: UserProfileViewSpy!
    
    override func setUp() {
        presenterSpy = .init()
        routerStub = .init()
        viewSpy = .init(user: .dummy(), feedRouter: routerStub)
        
        sut = .init(currentUser: .dummy(), presenter: presenterSpy, feedRouter: FeedRouterStub())
    }
    
    func test_loadView_shouldAssignExpectedView() {
        sut.loadView()
        
        XCTAssertTrue(sut.view is UserProfileView)
    }
    
    func test_viewWillAppear_withAnimated_shouldCallProfileViewUpdateFeed() {
        sut.profileView = viewSpy
        
        sut.viewWillAppear(true)
        
        XCTAssertTrue(viewSpy.isUpdateFeedCalled)
    }
    
    func test_updateUserInfo_shouldCallProfileViewUpdateUserInfo() {
        sut.profileView = viewSpy
        let expectedUser = User.dummy()
        
        sut.updateUserInfo()
        
        let actualUser = viewSpy.pushedUser
        XCTAssertEqual(expectedUser, actualUser)
        XCTAssertTrue(viewSpy.isUpdateUserInfoCalled)
    }
    
}
