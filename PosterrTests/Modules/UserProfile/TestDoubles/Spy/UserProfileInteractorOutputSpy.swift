//
//  UserProfileInteractorOutputSpy.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

@testable import Posterr

class UserProfileInteractorOutputSpy: UserProfileInteractorOutputProtocol {
    
    var pushedUser: User?
    var pushedError: RequestError?
    
    var isGetUserSucceededCalled = false
    var isOperationFailedCalled = false
    
    func getUserSucceeded(with user: User) {
        pushedUser = user
        isGetUserSucceededCalled = true
    }
    
    func operationFailed(with error: RequestError) {
        pushedError = error
        isOperationFailedCalled = true
    }
    
}
