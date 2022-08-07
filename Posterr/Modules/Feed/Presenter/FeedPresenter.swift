//
//  FeedPresenter.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit

final class FeedPresenter: NSObject, FeedPresenterProtocol {
    
    private let postMaximumCharacters = 777
    
    weak var view: FeedViewProtocol?
    private let interactor: FeedInteractorProtocol
    private var posts: [Post]?
    private var currentUser: User
    private var shouldDisplayOnlyUserPosts: Bool
    
    init(interactor: FeedInteractorProtocol, currentUser: User, shouldDisplayOnlyUserPosts: Bool) {
        self.interactor = interactor
        self.currentUser = currentUser
        self.shouldDisplayOnlyUserPosts = shouldDisplayOnlyUserPosts
    }
    
    func setup() {
        getPosts()
    }
    
    private func getPosts() {
        interactor.getPosts(from: shouldDisplayOnlyUserPosts ? currentUser : nil)
    }
    
    func updateLabelIfNeeded(_ postCreationView: PostCreationView, for textLength: Int) {
        guard shouldUpdateTextView(for: textLength) else { return }
        
        let text = textLength == 0 ? nil : String(postMaximumCharacters - textLength)
        
        DispatchQueue.main.async {
            postCreationView.updateRemainingCharacters(with: text)
        }
    }
    
    func shouldUpdateTextView(for length: Int) -> Bool {
        return length <= postMaximumCharacters
    }
    
    func post(_ message: String) {
        interactor.addNewPost(with: message, for: currentUser)
    }
    
    func repost(_ post: Post) {
        interactor.addRepost(of: post, for: currentUser)
    }
    
    func quote(_ post: Post, with message: String) {
        interactor.addQuotePost(for: post, with: message, by: currentUser)
    }
    
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    
    func getPostsSucceeded(with result: [Post]) {
        posts = result
        view?.reloadFeed()
    }
    
    func addNewPostSucceeded() {
        getPosts()
    }
    
    func addRepostSucceeded() {
        getPosts()
    }
    
    func addQuotePostSucceeded() {
        getPosts()
    }
    
}

extension FeedPresenter: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let post = posts?[safe: indexPath.row],
              let cell = dequeueCell(for: post, to: tableView, with: indexPath) else { return .init() }
        
        cell.setup(with: post)
        cell.delegate = view as? PostTableViewCellDelegate
        
        return cell
    }
    
    private func dequeueCell(for post: Post, to tableView: UITableView, with indexPath: IndexPath) -> PostCell? {
        guard post.quotePost == nil else {
            return tableView.dequeueReusableCell(withIdentifier: "QuoteTableViewCell", for: indexPath) as? QuoteTableViewCell
        }
        
        guard post.originalPost == nil else {
            return tableView.dequeueReusableCell(withIdentifier: "RepostTableViewCell", for: indexPath) as? RepostTableViewCell
        }
        
        return tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell
    }
    
}
