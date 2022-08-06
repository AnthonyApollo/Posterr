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
    
    var view: FeedViewProtocol? { get set }
    
    func setup()
    func updateLabelIfNeeded(_ postCreationView: PostCreationView, for textLength: Int)
    func shouldUpdateTextView(for length: Int) -> Bool
    func post(_: String)
    
}

protocol FeedInteractorProtocol: AnyObject {
    
    var output: FeedInteractorOutputProtocol? { get set }
    
    func getPosts()
    func addNewPost(with: String, for: User)
    
}

protocol FeedInteractorOutputProtocol: AnyObject {
    
    func getPostsSucceeded(with: [Post])
    func addNewPostSucceeded()
    
}

protocol PostCreationViewDelegate: AnyObject {
    
    func postCreationView(_: PostCreationView, shouldChangeTextIn: NSRange, with: String, for: UITextView) -> Bool
    func didPost(_: String)
    
}
