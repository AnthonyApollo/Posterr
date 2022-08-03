//
//  UserProfileViewController.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import Foundation
import UIKit

class UserProfileViewController: UIViewController {
    
    var tableViewManager = PostsTableViewManager(posts: Post.dummies())
    
    private lazy var profileView: UserProfileView = .init(user: .dummy(), tableViewManager: tableViewManager)
    
    override func loadView() {
        view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
}
