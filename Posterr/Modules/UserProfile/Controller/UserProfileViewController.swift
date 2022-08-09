//
//  UserProfileViewController.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import Foundation
import UIKit

final class UserProfileViewController: UIViewController {
    
    private let currentUser: DomainUser
    private lazy var profileView: UserProfileView = .init(user: currentUser, feedViewControllerDelegate: self)
    
    init(currentUser: DomainUser) {
        self.currentUser = currentUser
        
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

extension UserProfileViewController: FeedViewControllerDelegate {
    
    func didReloadFeed() {
        profileView.updateUserInfo()
    }
    
}
