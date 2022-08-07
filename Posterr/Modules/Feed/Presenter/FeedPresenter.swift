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
    
    func updateRemainingCharactersLabelIfNeeded(_ postCreationView: PostCreationView, for textLength: Int) {
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
    
    func getMorePostsSucceeded(with olderPosts: [Post]) {
        insert(olderPosts: olderPosts)
    }
    
    func addNewPostSucceeded(with post: Post) {
        insert(post: post)
    }
    
    func addRepostSucceeded(with post: Post) {
        insert(post: post)
    }
    
    func addQuotePostSucceeded(with post: Post) {
        insert(post: post)
    }
    
    func operationFailed(with error: RequestError) {
        view?.displayAlert(with: "Oops, something went wrong.", and: error.errorDescription)
    }
    
    private func insert(post: Post) {
        posts?.insert(post, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        
        DispatchQueue.main.async {
            self.view?.insertPosts(at: [indexPath])
        }
    }
    
    private func insert(olderPosts: [Post]) {
        let offset = posts?.count ?? 0
        posts = (posts ?? []) + olderPosts
        
        let indexPaths = olderPosts.enumerated().map { index, _ in
            IndexPath(row: offset + index, section: 0)
        }
        
        DispatchQueue.main.async {
            self.view?.insertPosts(at: indexPaths)
        }
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
        
        getMorePostsIfNeeded(for: indexPath)
        
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
    
    private func getMorePostsIfNeeded(for indexPath: IndexPath) {
        guard let posts = posts else { return }
        
        if indexPath.row == posts.count - 1 {
            interactor.getMorePosts(from: currentUser)
        }
    }
    
}
