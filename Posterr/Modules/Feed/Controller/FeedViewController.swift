//
//  FeedViewController.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import Foundation
import UIKit

class FeedViewController: UIViewController {
    
    var tableViewManager = PostsTableViewManager(posts: Post.dummies())
    
    private lazy var feedView: FeedView = .init(tableViewManager: tableViewManager)
    
    override func loadView() {
        view = feedView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
