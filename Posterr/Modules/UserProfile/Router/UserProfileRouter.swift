//
//  UserProfileRouter.swift
//  Posterr
//
//  Created by Anthony Apollo on 09/08/22.
//

import UIKit

struct UserProfileRouter {
    
    static func createModule(with user: User) -> UserProfileViewController {
        let interactor = UserProfileInteractor()
        let presenter = UserProfilePresenter(interactor: interactor)
        let viewController = UserProfileViewController(currentUser: user, presenter: presenter)
        
        interactor.output = presenter
        presenter.view = viewController
        
        viewController.tabBarItem = .init(title: Strings.profileTabBarTitle(), image: UIImage.fromSystem(named: SystemIcons.userTabBarIcon()), tag: 1)
        viewController.tabBarItem.selectedImage = UIImage.fromSystem(named: SystemIcons.userTabBarIconSelected())
        
        return viewController
    }
    
}
