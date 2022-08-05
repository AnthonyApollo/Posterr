//
//  FeedProtocols.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit

protocol FeedViewProtocol: AnyObject {
    
    func reloadFeed()
    
}

protocol FeedPresenterProtocol: AnyObject {
    
    var tableViewManager: PostsTableViewManager { get }
    var view: FeedViewProtocol? { get set }
    
    func setup()
    func updateLabelIfNeeded(_ postCreationView: PostCreationView, for textLength: Int)
    func shouldUpdateTextView(for length: Int) -> Bool
    
}

protocol FeedInteractorProtocol: AnyObject {
    
    var output: FeedInteractorOutputProtocol? { get set }
    
    func getPosts()
    
}

protocol FeedInteractorOutputProtocol: AnyObject {
    
    func getPostsSuccess(result: [Post])
    
}

protocol PostCreationViewDelegate: AnyObject {
    
    func postCreationView(_: PostCreationView, shouldChangeTextIn: NSRange, with: String, for: UITextView) -> Bool
    
}
