//
//  FeedRouter.swift
//  Posterr
//
//  Created by Anthony Apollo on 09/08/22.
//

import UIKit

protocol FeedRouterProtocol {
    
    func createModule(with user: User, toUserProfile isOnUserProfile: Bool) -> FeedViewProtocol
    func createModule(with user: User, and delegate: FeedViewControllerDelegate?) -> FeedViewProtocol
}

final class FeedRouter: FeedRouterProtocol {
    
    func createModule(with user: User, toUserProfile isOnUserProfile: Bool = false) -> FeedViewProtocol {
        let interactor = FeedInteractor()
        let presenter = FeedPresenter(interactor: interactor, currentUser: user, shouldDisplayOnlyUserPosts: isOnUserProfile)
        let viewController = FeedViewController(presenter: presenter)
        
        interactor.output = presenter
        presenter.view = viewController
        
        viewController.tabBarItem = .init(title: Strings.feedTabBarTitle(), image: UIImage.fromSystem(named: SystemIcons.feedTabBarIcon()), tag: 0)
        viewController.tabBarItem.selectedImage = UIImage.fromSystem(named: SystemIcons.feedTabBarIconSelected())
        
        return viewController
    }
    
    func createModule(with user: User, and delegate: FeedViewControllerDelegate?) -> FeedViewProtocol {
        let viewController = createModule(with: user, toUserProfile: true)
        viewController.delegate = delegate
        
        return viewController
    }
    
}
