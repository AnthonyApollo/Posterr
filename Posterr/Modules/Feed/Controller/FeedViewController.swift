//
//  FeedViewController.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import UIKit

final class FeedViewController: UIViewController {
    
    private let presenter: FeedPresenterProtocol
    private let feedView: FeedView
    weak var delegate: FeedViewControllerDelegate?
    
    init(presenter: FeedPresenterProtocol) {
        self.presenter = presenter
        self.feedView = .init()
        
        super.init(nibName: nil, bundle: nil)
        
        feedView.postCreationView.delegate = self
        feedView.postsTableView.dataSource = presenter as? UITableViewDataSource
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = feedView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateUI()
    }
    
    func updateUI() {
        presenter.setup()
    }
    
}

extension FeedViewController: FeedViewProtocol {
    
    func reloadFeed() {
        feedView.reload()
        delegate?.didReloadFeed()
    }
    
    func insertPosts(at indexPaths: [IndexPath]) {
        feedView.insertPosts(at: indexPaths)
        delegate?.didReloadFeed()
    }
    
    func updateRemainingCharacters(with count: String?) {
        feedView.updateRemainingCharacters(with: count)
    }
    
    func enablePostButton() {
        feedView.enablePostButton()
    }
    
    func disablePostButton() {
        feedView.disablePostButton()
    }
    
}

extension FeedViewController: PostCreationViewDelegate {
    
    func didPost(_ message: String) {
        presenter.post(message)
    }
    
    func didPost(_ message: String, with post: Post) {
        presenter.quote(post, with: message)
    }
    
    func shouldUpdateTextView(for textLength: Int) -> Bool {
        presenter.updatePostCreationViewIfNeeded(for: textLength)
        
        return presenter.shouldUpdateTextView(for: textLength)
    }
    
}

extension FeedViewController: PostTableViewCellDelegate {
    
    func didTapRepost(for post: Post) {
        if let originalPost = post.originalPost {
            didTapRepost(for: originalPost)
        }
        
        if let quotePost = post.quotePost {
            didTapRepost(for: quotePost)
        }
        
        guard let username = post.author?.username,
              let postMessage = post.message else { return }
        
        let title = "Are you sure you want to repost \(username)?"
        let message = "\"\(postMessage)\""
        
        displayActionSheet(for: title, and: message, confirmHandler: { [weak self] in
            self?.presenter.repost(post)
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
        
        feedView.setupQuote(of: post)
    }
    
}
