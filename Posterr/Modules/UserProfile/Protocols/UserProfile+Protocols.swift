//
//  UserProfileProtocols.swift
//  Posterr
//
//  Created by Anthony Apollo on 05/08/22.
//

protocol UserProfileViewProtocol: AnyObject {
    
    var presenter: UserProfilePresenterProtocol { get }
    
}

protocol UserProfilePresenterProtocol: AnyObject {
    
    var interactor: UserProfileInteractorProtocol { get }
    var view: UserProfileViewProtocol { get set }
    
    func setup()
    
}

protocol UserProfileInteractorProtocol: AnyObject {
    
    var output: UserProfileInteractorOutputProtocol { get set }
    
    func getDefaultUser()
    
}

protocol UserProfileInteractorOutputProtocol: AnyObject {
    
    func getDefaultUserSucceeded(with result: User)
    
}
