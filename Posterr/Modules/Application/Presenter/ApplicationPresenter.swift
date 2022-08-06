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
    }
    
    func setup() {
        interactor.getCurrentUser()
    }
    
    
}

extension ApplicationPresenter: ApplicationInteractorOutputProtocol {
    
    func getCurrentUserSucceeded(with user: User) {
        view?.currentUser = user
    }
    
}
