//
//  UserProfilePresenter.swift
//  Posterr
//
//  Created by Anthony Apollo on 05/08/22.
//

import Foundation

final class UserProfilePresenter: UserProfilePresenterProtocol {
    
    let interactor: UserProfileInteractorProtocol
    weak var view: UserProfileViewProtocol?
    
    init(interactor: UserProfileInteractorProtocol) {
        self.interactor = interactor
    }
    
    func setup() {
        // TODO
    }
    
}

extension UserProfilePresenter: UserProfileInteractorOutputProtocol {
    
    func getDefaultUserSucceeded(with result: User) {
        // TODO
    }
    
}
