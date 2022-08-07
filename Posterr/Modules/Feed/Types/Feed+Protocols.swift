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
    func repost(_: Post)
    
}

protocol FeedInteractorProtocol: AnyObject {
    
    var output: FeedInteractorOutputProtocol? { get set }
    
    func getPosts(from: User?)
    func addNewPost(with: String, for: User)
    func addRepost(of: Post, for: User)
    
}

protocol FeedInteractorOutputProtocol: AnyObject {
    
    func getPostsSucceeded(with: [Post])
    func addNewPostSucceeded()
    func addRepostSucceeded()
    
}

protocol PostCell: UITableViewCell {
    
    var delegate: PostTableViewCellDelegate? { get set }
    
    func setup(with: Post)
    
}

protocol PostCreationViewDelegate: AnyObject {
    
    func postCreationView(_: PostCreationView, shouldChangeTextIn: NSRange, with: String, for: UITextView) -> Bool
    func didPost(_: String)
    
}

protocol PostTableViewCellDelegate: AnyObject {
    
    func didTapRepost(for: Post)
    func didTapQuote(for: Post)
    
}

protocol PostReplyMenuDelegate: AnyObject {
    
    func didTapRepost()
    func didTapQuote()
    
}
