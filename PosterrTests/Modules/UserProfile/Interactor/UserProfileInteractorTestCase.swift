//
//  UserProfileInteractorTestCase.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import XCTest
@testable import Posterr

class UserProfileInteractorTestCase: XCTestCase {
    
    var sut: UserProfileInteractor!
    var dataSourceStub: AppDataSourceStub!
    var outputSpy: UserProfileInteractorOutputSpy!
    
    override func setUp() {
        super.setUp()
        
        dataSourceStub = .init()
        outputSpy = .init()
        
        sut = .init(appDataSource: dataSourceStub)
        
        sut.output = outputSpy
    }
    
    func test_getUser_withSuccessfullRequest_shouldCallOutputGetUserSucceeded() throws {
        let expectedUser: User = .dummy()
        
        sut.getUser()
        
        let actualUser = try XCTUnwrap(outputSpy.pushedUser)
        XCTAssertEqual(expectedUser, actualUser)
        XCTAssertTrue(outputSpy.isGetUserSucceededCalled)
    }
    
    func test_getUser_withFailedRequest_shouldCallOutputGetUserSucceeded() throws {
        let expectedError: RequestError = .fetchError
        
        dataSourceStub.requestShouldFail = true
        sut.getUser()
        
        let actualError = try XCTUnwrap(outputSpy.pushedError)
        XCTAssertEqual(expectedError, actualError)
        XCTAssertTrue(outputSpy.isOperationFailedCalled)
    }
    
}
