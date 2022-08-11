//
//  UserProfileViewProtocolSpy.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import UIKit
@testable import Posterr

class UserProfileViewProtocolSpy: UIViewController, UserProfileViewProtocol {
    
    var currentUser: User = .dummy()
    
    var isUpdateUserInfoCalled = false
    var isDisplayAlertCalled = false
    
    func updateUserInfo() {
        isUpdateUserInfoCalled = true
    }
    
}
