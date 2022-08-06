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
        
        let interactor = FeedInteractor()
        let presenter = FeedPresenter(interactor: interactor, currentUser: currentUser)
        let viewController = FeedViewController(presenter: presenter)
        
        interactor.output = presenter
        presenter.view = viewController
        
        viewController.tabBarItem = .init(title: "Feed", image: UIImage(systemName: "bubble.left"), tag: 0)
        viewController.tabBarItem.selectedImage = .init(systemName: "bubble.left.fill")
        
        return viewController
    }()
    
    private lazy var userProfileViewController: UIViewController = {
        guard let currentUser = currentUser else {
            return UIViewController(nibName: nil, bundle: nil)
        }
        
        let viewController = UserProfileViewController(currentUser: currentUser)
        
        viewController.tabBarItem = .init(title: "Profile", image: .init(systemName: "person.text.rectangle"), tag: 1)
        viewController.tabBarItem.selectedImage = .init(systemName: "person.text.rectangle.fill")
        
        return viewController
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
