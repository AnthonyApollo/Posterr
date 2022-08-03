//
//  HomeTabBarController.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import Foundation
import UIKit

class HomeTabBarController: UITabBarController {
    
    private let feedViewController: UIViewController = {
        let viewController = FeedViewController()
        viewController.tabBarItem = .init(title: "Feed", image: UIImage(systemName: "message"), tag: 0)
        return viewController
    }()
    
    private let userProfileViewController: UIViewController = {
        let viewController = UserProfileViewController()
        viewController.tabBarItem = .init(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        return viewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTabBar()
    }
    
    private func configTabBar() {
        viewControllers = [feedViewController, userProfileViewController]
        tabBar.backgroundColor = .white
    }
    
}
