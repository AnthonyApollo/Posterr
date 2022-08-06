//
//  UserProfileProtocols.swift
//  Posterr
//
//  Created by Anthony Apollo on 05/08/22.
//

protocol UserProfileViewProtocol: AnyObject {
    
    var presenter: UserProfilePresenterProtocol { get }
    
    func updateProfile(with: User)
    
}

protocol UserProfilePresenterProtocol: AnyObject {
    
    var view: UserProfileViewProtocol? { get set }
    
    func setup()
    
}
