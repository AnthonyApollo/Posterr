//
//  UserProfilePresenter.swift
//  Posterr
//
//  Created by Anthony Apollo on 05/08/22.
//

import Foundation

final class UserProfilePresenter: UserProfilePresenterProtocol {
    
    weak var view: UserProfileViewProtocol?
    private var currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
    }
    
    func setup() {
        view?.updateProfile(with: currentUser)
    }
    
}
