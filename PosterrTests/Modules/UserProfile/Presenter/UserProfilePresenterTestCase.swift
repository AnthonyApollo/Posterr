//
//  UserProfilePresenterTestCase.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import XCTest
@testable import Posterr

class UserProfilePresenterTestCase: XCTestCase {
    
    var sut: UserProfilePresenter!
    var interactorSpy: UserProfileInteractorSpy!
    var viewSpy: UserProfileViewProtocolSpy!
    
    override func setUp() {
        super.setUp()
        
        interactorSpy = .init()
        viewSpy = .init()
        
        sut = .init(interactor: interactorSpy)
        sut.view = viewSpy
    }
    
    func test_updateUser_shouldCallInteractorGetUser() {
        sut.updateUser()
        
        XCTAssertTrue(interactorSpy.isGetUserCalled)
    }
    
    func test_getUserSucceeded_shouldCallViewUpdateUserInfo() {
        let expectedUser: User = .dummy2()
        
        sut.getUserSucceeded(with: .dummy2())
        
        let actualUser = viewSpy.currentUser
        XCTAssertEqual(expectedUser, actualUser)
        XCTAssertTrue(viewSpy.isUpdateUserInfoCalled)
    }
    
}
