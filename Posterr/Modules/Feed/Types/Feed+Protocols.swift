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
    func setupQuote(of: DomainPost)
    
}

protocol FeedPresenterProtocol: AnyObject {
    
    var view: FeedViewProtocol? { get set }
    
    func setup()
    func updatePostCreationViewIfNeeded(for: Int)
    func shouldUpdateTextView(for: Int) -> Bool
    func post(_: String)
    func repost(_: DomainPost)
    func quote(_: DomainPost, with: String)
    func didTapRepost(for: DomainPost)
    func didTapQuote(for: DomainPost)
    
}

protocol FeedInteractorProtocol: AnyObject {
    
    var output: FeedInteractorOutputProtocol? { get set }
    
    func getPosts(from: User?)
    func getMorePosts(from user: User?)
    func addNewPost(with: String, for: User)
    func addRepost(of: DomainPost, for: User)
    func addQuotePost(for: DomainPost, with: String, by: User)
    
}

protocol FeedInteractorOutputProtocol: AnyObject {
    
    func getPostsSucceeded(with: [DomainPost])
    func getMorePostsSucceeded(with: [DomainPost])
    func addNewPostSucceeded(with: DomainPost)
    func addRepostSucceeded(with: DomainPost)
    func addQuotePostSucceeded(with: DomainPost)
    func operationFailed(with: RequestError)
    
}

protocol PostCell: UITableViewCell {
    
    var delegate: PostTableViewCellDelegate? { get set }
    
    func setup(with: DomainPost)
    
}

protocol PostTableViewCellDelegate: AnyObject {
    
    func didTapRepost(for: DomainPost)
    func didTapQuote(for: DomainPost)
    
}
