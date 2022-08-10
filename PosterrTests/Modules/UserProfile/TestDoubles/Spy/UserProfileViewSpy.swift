//
//  UserProfileViewSpy.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

@testable import Posterr

class UserProfileViewSpy: UserProfileView {
    
    var pushedUser: User?
    
    var isUpdateFeedCalled = false
    var isUpdateUserInfoCalled = false
    
    override func updateFeed() {
        isUpdateFeedCalled = true
    }
    
    override func updateUserInfo(with user: User) {
        pushedUser = user
        isUpdateUserInfoCalled = true
    }
    
}
