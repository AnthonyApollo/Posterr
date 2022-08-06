//
//  Application+Protocols.swift
//  Posterr
//
//  Created by Anthony Apollo on 05/08/22.
//

protocol ApplicationViewProtocol: AnyObject {
    
    var currentUser: User? { get set }
    var presenter: ApplicationPresenterProtocol { get }
    
}

protocol ApplicationPresenterProtocol: AnyObject {
    
    var interactor: ApplicationInteractorProtocol { get }
    var view: ApplicationViewProtocol? { get set }
    
    func setup()
    
}

protocol ApplicationInteractorProtocol: AnyObject {
    
    var output: ApplicationInteractorOutputProtocol? { get set }
    
    func getCurrentUser()
    
}

protocol ApplicationInteractorOutputProtocol: AnyObject {
    
    func getCurrentUserSucceeded(with: User)
    
}
