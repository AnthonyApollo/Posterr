//
//  ApplicationPresenter.swift
//  Posterr
//
//  Created by Anthony Apollo on 05/08/22.
//

final class ApplicationPresenter: ApplicationPresenterProtocol {
    
    let interactor: ApplicationInteractorProtocol
    weak var view: ApplicationViewProtocol?
    
    init(interactor: ApplicationInteractorProtocol) {
        self.interactor = interactor
        
        self.interactor.output = self
    }
    
    func setup() {
        interactor.getCurrentUser()
    }
    
    
}

extension ApplicationPresenter: ApplicationInteractorOutputProtocol {
    
    func getCurrentUserSucceeded(with user: User) {
        view?.currentUser = user
    }
    
    func operationFailed(with error: RequestError) {
        view?.displayAlert(with: Strings.errorAlertTitle(), and: error.errorDescription)
    }
    
}
