//
//  FeedRouter.swift
//  Posterr
//
//  Created by Anthony Apollo on 09/08/22.
//

import UIKit

struct FeedRouter {
    
    static func createModule(with user: User) -> FeedViewController {
        let interactor = FeedInteractor()
        let presenter = FeedPresenter(interactor: interactor, currentUser: user, shouldDisplayOnlyUserPosts: false)
        let viewController = FeedViewController(presenter: presenter)
        
        interactor.output = presenter
        presenter.view = viewController
        
        viewController.tabBarItem = .init(title: Strings.feedTabBarTitle(), image: UIImage.fromSystem(named: SystemIcons.feedTabBarIcon()), tag: 0)
        viewController.tabBarItem.selectedImage = UIImage.fromSystem(named: SystemIcons.feedTabBarIconSelected())
        
        return viewController
    }
    
    static func createModule(with user: User, and delegate: FeedViewControllerDelegate?) -> FeedViewController {
        let viewController = createModule(with: user)
        viewController.delegate = delegate
        
        return viewController
    }
    
}
