//
//  UserProfileViewController.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import Foundation
import UIKit

final class UserProfileViewController: UIViewController {
    
    let presenter: UserProfilePresenterProtocol
    private lazy var profileView: UserProfileView = .init()
    
    init(presenter: UserProfilePresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setup()
    }
    
}

extension UserProfileViewController: UserProfileViewProtocol {
    
    func updateProfile(with user: UserEntity) {
        profileView.update(with: user)
    }
    
}
