//
//  FeedPresenter.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit

final class FeedPresenter: NSObject {
    
    private let postMaximumCharacters = 777
    
    weak var view: FeedViewProtocol?
    private let interactor: FeedInteractorProtocol
    private var posts: [DomainPost]?
    private var currentUser: User
    private var shouldDisplayOnlyUserPosts: Bool
    
    init(interactor: FeedInteractorProtocol, currentUser: User, shouldDisplayOnlyUserPosts: Bool) {
        self.interactor = interactor
        self.currentUser = currentUser
        self.shouldDisplayOnlyUserPosts = shouldDisplayOnlyUserPosts
    }
    
    private func getPosts() {
        interactor.getPosts(from: shouldDisplayOnlyUserPosts ? currentUser : nil)
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
    
    private func insert(post: DomainPost) {
        posts?.insert(post, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        
        DispatchQueue.main.async {
            self.view?.insertPosts(at: [indexPath])
        }
    }
    
    private func insert(olderPosts: [DomainPost]) {
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
    
    private func dequeueCell(for post: DomainPost, to tableView: UITableView, with indexPath: IndexPath) -> PostCell? {
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
            let user = shouldDisplayOnlyUserPosts ? currentUser : nil
            interactor.getMorePosts(from: user)
        }
    }
    
}

extension FeedPresenter: FeedPresenterProtocol {
    
    func setup() {
        getPosts()
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
        interactor.addNewPost(with: message, for: currentUser)
    }
    
    func repost(_ post: DomainPost) {
        interactor.addRepost(of: post, for: currentUser)
    }
    
    func quote(_ post: DomainPost, with message: String) {
        interactor.addQuotePost(for: post, with: message, by: currentUser)
    }
    
    func didTapRepost(for post: DomainPost) {
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
    
    func didTapQuote(for post: DomainPost) {
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
    
    func getPostsSucceeded(with result: [DomainPost]) {
        posts = result
        view?.reloadFeed()
    }
    
    func getMorePostsSucceeded(with olderPosts: [DomainPost]) {
        insert(olderPosts: olderPosts)
    }
    
    func addNewPostSucceeded(with post: DomainPost) {
        scrollFeedToTop()
        insert(post: post)
    }
    
    func addRepostSucceeded(with post: DomainPost) {
        scrollFeedToTop()
        insert(post: post)
    }
    
    func addQuotePostSucceeded(with post: DomainPost) {
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
