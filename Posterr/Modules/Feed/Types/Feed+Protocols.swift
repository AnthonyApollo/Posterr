//
//  FeedProtocols.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit

protocol FeedViewProtocol: UIViewController {
    
    func reloadFeed()
    func insertPosts(at: [IndexPath])
    
}

protocol FeedPresenterProtocol: AnyObject {
    
    var view: FeedViewProtocol? { get set }
    
    func setup()
    func updateRemainingCharactersLabelIfNeeded(_ postCreationView: PostCreationView, for textLength: Int)
    func shouldUpdateTextView(for length: Int) -> Bool
    func post(_: String)
    func repost(_: Post)
    func quote(_: Post, with: String)
    
}

protocol FeedInteractorProtocol: AnyObject {
    
    var output: FeedInteractorOutputProtocol? { get set }
    
    func getPosts(from: User?)
    func addNewPost(with: String, for: User)
    func addRepost(of: Post, for: User)
    func addQuotePost(for: Post, with: String, by: User)
    
}

protocol FeedInteractorOutputProtocol: AnyObject {
    
    func getPostsSucceeded(with: [Post])
    func addNewPostSucceeded(with: Post)
    func addRepostSucceeded(with: Post)
    func addQuotePostSucceeded(with: Post)
    func operationFailed(with: RequestError)
    
}

protocol PostCell: UITableViewCell {
    
    var delegate: PostTableViewCellDelegate? { get set }
    
    func setup(with: Post)
    
}

protocol PostCreationViewDelegate: AnyObject {
    
    func postCreationView(_: PostCreationView, shouldChangeTextIn: NSRange, with: String, for: UITextView) -> Bool
    func didPost(_: String)
    func didPost(_: String, with: Post)
    
}

protocol PostTableViewCellDelegate: AnyObject {
    
    func didTapRepost(for: Post)
    func didTapQuote(for: Post)
    
}

protocol PostReplyMenuDelegate: AnyObject {
    
    func didTapRepost()
    func didTapQuote()
    
}

protocol PostMessageViewDelegate: AnyObject {
    
    func didTouchCloseButton()
    
}

protocol FeedViewControllerDelegate: AnyObject {
    
    func didReloadFeed()
    
}
