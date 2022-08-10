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
    func updateRemainingCharacters(with: String?)
    func enablePostButton()
    func disablePostButton()
    func scrollFeed(to: IndexPath)
    func setupQuote(of: Post)
    
}

protocol FeedPresenterProtocol: AnyObject {
    
    var view: FeedViewProtocol? { get set }
    
    func setup()
    func updatePostCreationViewIfNeeded(for: Int)
    func shouldUpdateTextView(for: Int) -> Bool
    func post(_: String)
    func repost(_: Post)
    func quote(_: Post, with: String)
    func didTapRepost(for: Post)
    func didTapQuote(for: Post)
    
}

protocol FeedInteractorProtocol: AnyObject {
    
    var output: FeedInteractorOutputProtocol? { get set }
    
    func getPosts(from: User?)
    func getPostCount(of: User, for: Date)
    func getMorePosts(from user: User?)
    func addNewPost(with: String, for: User)
    func addRepost(of: Post, for: User)
    func addQuotePost(for: Post, with: String, by: User)
    
}

protocol FeedInteractorOutputProtocol: AnyObject {
    
    func getPostsSucceeded(with: [Post])
    func getPostsCountSucceeded(with: Int)
    func getMorePostsSucceeded(with: [Post])
    func addNewPostSucceeded(with: Post)
    func addRepostSucceeded(with: Post)
    func addQuotePostSucceeded(with: Post)
    func operationFailed(with: RequestError)
    
}

protocol PostCell: UITableViewCell {
    
    var delegate: PostTableViewCellDelegate? { get set }
    
    func setup(with: Post)
    
}

protocol PostTableViewCellDelegate: AnyObject {
    
    func didTapRepost(for: Post)
    func didTapQuote(for: Post)
    
}
