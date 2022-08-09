//
//  UserProfile+Protocols.swift
//  Posterr
//
//  Created by Anthony Apollo on 09/08/22.
//

import UIKit

protocol UserProfileViewProtocol: UIViewController {
    
    var currentUser: User { get set }
    
    func updateUserInfo()
    
}

protocol UserProfilePresenterProtocol: AnyObject {
    
    func updateUser()
    
}

protocol UserProfileInteractorProtocol: AnyObject {
    
    func getUser()
    
}

protocol UserProfileInteractorOutputProtocol: AnyObject {
    
    func getUserSucceeded(with: User)
    func operationFailed(with: RequestError)
    
}
