//
//  UserProfilePresenterSpy.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

@testable import Posterr

class UserProfilePresenterSpy: UserProfilePresenterProtocol {
    
    var isUpdateUserCalled = false
    
    func updateUser() {
        isUpdateUserCalled = true
    }
    
}
