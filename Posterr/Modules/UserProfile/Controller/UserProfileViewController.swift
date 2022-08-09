//
//  UserProfileViewController.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import Foundation
import UIKit

final class UserProfileViewController: UIViewController {
    
    var currentUser: User
    let presenter: UserProfilePresenterProtocol
    
    private lazy var profileView: UserProfileView = .init(user: currentUser, feedViewControllerDelegate: self)
    
    init(currentUser: User, presenter: UserProfilePresenterProtocol) {
        self.currentUser = currentUser
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = profileView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        profileView.updateFeed()
    }
    
}

extension UserProfileViewController: UserProfileViewProtocol {
    
    func updateUserInfo() {
        profileView.updateUserInfo(with: currentUser)
    }
    
}

extension UserProfileViewController: FeedViewControllerDelegate {
    
    func didReloadFeed() {
        presenter.updateUser()
    }
    
}
