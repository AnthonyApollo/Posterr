//
//  UserProfileViewController.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController {
    
    private lazy var profileView: UserProfileView = .init(user: .dummy())
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
}
