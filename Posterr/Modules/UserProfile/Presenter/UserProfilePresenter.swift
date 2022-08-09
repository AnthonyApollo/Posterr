//
//  UserProfilePresenter.swift
//  Posterr
//
//  Created by Anthony Apollo on 09/08/22.
//

final class UserProfilePresenter: UserProfilePresenterProtocol {
    
    private let interactor: UserProfileInteractorProtocol
    weak var view: UserProfileViewProtocol?
    
    init(interactor: UserProfileInteractorProtocol) {
        self.interactor = interactor
    }
    
    func updateUser() {
        interactor.getUser()
    }
    
}

extension UserProfilePresenter: UserProfileInteractorOutputProtocol {
    
    func getUserSucceeded(with user: User) {
        view?.currentUser = user
        view?.updateUserInfo()
    }
    
    func operationFailed(with error: RequestError) {
        view?.displayAlert(with: Strings.errorAlertTitle(), and: error.errorDescription)
    }
    
}
