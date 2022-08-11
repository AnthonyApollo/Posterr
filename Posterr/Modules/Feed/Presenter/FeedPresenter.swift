//
//  FeedPresenter.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit

final class FeedPresenter: NSObject {
    
    private let postMaximumCharacters = 777
    private let maximumPostsPerDay = 5
    private var postsToday = 0
    
    weak var view: FeedViewProtocol?
    private let interactor: FeedInteractorProtocol
    private var posts: [Post]?
    private var currentUser: User
    var isOnUserProfile: Bool
    
    init(interactor: FeedInteractorProtocol, currentUser: User, isOnUserProfile: Bool) {
        self.interactor = interactor
        self.currentUser = currentUser
        self.isOnUserProfile = isOnUserProfile
    }
    
    private var canUserPost: Bool {
        return postsToday < maximumPostsPerDay
    }
    
    private func getPosts() {
        interactor.getPosts(from: isOnUserProfile ? currentUser : nil)
    }
    
    private func updatePostCreation(with remainingCharacters: String) {
        DispatchQueue.main.async {
            self.view?.enablePostButton()
            self.view?.updateRemainingCharacters(with: remainingCharacters)
        }
    }
    
    private func disablePostCreation() {
        DispatchQueue.main.async {
            self.view?.disablePostButton()
            self.view?.updateRemainingCharacters(with: nil)
        }
    }
    
    private func insert(post: Post) {
        postsToday += 1
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
    
    private func scrollFeedToTop() {
        view?.scrollFeed(to: IndexPath(row: 0, section: 0))
    }
    
    private func dequeueCell(for post: Post, to tableView: UITableView, with indexPath: IndexPath) -> PostCell? {
        guard post.quotePost == nil else {
            return tableView.dequeueReusableCell(withIdentifier: QuoteTableViewCell.reuseIdentifier, for: indexPath)
        }
        
        guard post.originalPost == nil else {
            return tableView.dequeueReusableCell(withIdentifier: RepostTableViewCell.reuseIdentifier, for: indexPath)
        }
        
        return tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.reuseIdentifier, for: indexPath)
    }
    
    private func getMorePostsIfNeeded(for indexPath: IndexPath) {
        guard let posts = posts else { return }
        
        if indexPath.row == posts.count - 1 {
            let user = isOnUserProfile ? currentUser : nil
            interactor.getMorePosts(from: user)
        }
    }
    
    private func displayPostLimitMessage() {
        view?.displayAlert(with: Strings.postLimitTitle(), and: Strings.postLimitMessage())
    }
    
}

extension FeedPresenter: FeedPresenterProtocol {
    
    func setup() {
        getPosts()
        interactor.getPostCount(of: currentUser, for: Date())
    }
    
    func updatePostCreationViewIfNeeded(for textViewLength: Int) {
        guard shouldUpdateTextView(for: textViewLength) else { return }
        
        guard textViewLength > 0 else {
            disablePostCreation()
            return
        }
        
        let remainingCharacters = String(postMaximumCharacters - textViewLength)
        updatePostCreation(with: remainingCharacters)
    }
    
    func shouldUpdateTextView(for length: Int) -> Bool {
        return length <= postMaximumCharacters
    }
    
    func post(_ message: String) {
        if canUserPost {
            interactor.addNewPost(with: message, for: currentUser)
            return
        }
        
        displayPostLimitMessage()
    }
    
    func repost(_ post: Post) {
        if canUserPost {
            interactor.addRepost(of: post, for: currentUser)
            return
        }
        
        displayPostLimitMessage()
    }
    
    func quote(_ post: Post, with message: String) {
        if canUserPost {
            interactor.addQuotePost(for: post, with: message, by: currentUser)
            return
        }
        
        displayPostLimitMessage()
    }
    
    func didTapRepost(for post: Post) {
        if let originalPost = post.originalPost {
            didTapRepost(for: originalPost)
        }
        
        if let quotePost = post.quotePost {
            didTapRepost(for: quotePost)
        }
        
        guard let postMessage = post.message else { return }
        
        let title = Strings.repostActionSheetTitle(post.author)
        let message = Strings.repostActionSheetMessage(postMessage)
        
        view?.displayActionSheet(for: title, and: message, confirmHandler: { [weak self] in
            self?.repost(post)
        })
    }
    
    func didTapQuote(for post: Post) {
        if let originalPost = post.originalPost {
            didTapQuote(for: originalPost)
            return
        }
        
        if let quotePost = post.quotePost {
            didTapQuote(for: quotePost)
            return
        }
        
        view?.setupQuote(of: post)
    }
    
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    
    func getPostsSucceeded(with result: [Post]) {
        posts = result
        view?.reloadFeed()
    }
    
    func getPostsCountSucceeded(with count: Int) {
        postsToday = count
    }
    
    func getMorePostsSucceeded(with olderPosts: [Post]) {
        insert(olderPosts: olderPosts)
    }
    
    func addNewPostSucceeded(with post: Post) {
        scrollFeedToTop()
        insert(post: post)
    }
    
    func addRepostSucceeded(with post: Post) {
        scrollFeedToTop()
        insert(post: post)
    }
    
    func addQuotePostSucceeded(with post: Post) {
        scrollFeedToTop()
        insert(post: post)
    }
    
    func operationFailed(with error: RequestError) {
        view?.displayAlert(with: Strings.errorAlertTitle(), and: error.errorDescription)
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
    
}
