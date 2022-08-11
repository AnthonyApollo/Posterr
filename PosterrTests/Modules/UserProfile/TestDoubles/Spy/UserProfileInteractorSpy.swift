//
//  UserProfileInteractorSpy.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

@testable import Posterr

class UserProfileInteractorSpy: UserProfileInteractorProtocol {
    
    var isGetUserCalled = false
    
    func getUser() {
        isGetUserCalled = true
    }
    
}
