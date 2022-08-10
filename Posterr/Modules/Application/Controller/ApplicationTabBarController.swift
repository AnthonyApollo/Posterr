//
//  ApplicationTabBarController.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import Foundation
import UIKit

final class ApplicationTabBarController: UITabBarController, ApplicationViewProtocol {
    
    var currentUser: User?
    let presenter: ApplicationPresenterProtocol
    
    init(presenter: ApplicationPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
        
        self.presenter.view = self
        self.presenter.setup()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var feedViewController: UIViewController = {
        guard let currentUser = currentUser else {
            return UIViewController(nibName: nil, bundle: nil)
        }
        
        return FeedRouter().createModule(with: currentUser)
    }()
    
    private lazy var userProfileViewController: UIViewController = {
        guard let currentUser = currentUser else {
            return UIViewController(nibName: nil, bundle: nil)
        }
        
        return UserProfileRouter.createModule(with: currentUser)
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configTabBar()
    }
    
    private func configTabBar() {
        viewControllers = [feedViewController, userProfileViewController]
        tabBar.backgroundColor = .systemGray6
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.separator.cgColor
        tabBar.clipsToBounds = true
    }
    
}
