//
//  UserProfileRouter.swift
//  Posterr
//
//  Created by Anthony Apollo on 09/08/22.
//

import UIKit

struct UserProfileRouter {
    
    static func createModule(with user: User) -> UserProfileViewController {
        let viewController = UserProfileViewController(currentUser: user)
        
        viewController.tabBarItem = .init(title: Strings.profileTabBarTitle(), image: UIImage.fromSystem(named: SystemIcons.userTabBarIcon()), tag: 1)
        viewController.tabBarItem.selectedImage = UIImage.fromSystem(named: SystemIcons.userTabBarIconSelected())
        
        return viewController
    }
    
}
