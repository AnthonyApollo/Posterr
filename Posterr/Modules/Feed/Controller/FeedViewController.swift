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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.setup()
    }
    
}

extension FeedViewController: FeedViewProtocol {
    
    func reloadFeed() {
        feedView.reload()
    }
    
}

extension FeedViewController: PostCreationViewDelegate {
    
    func didPost(_ message: String) {
        presenter.post(message)
    }
    
    func postCreationView(_ postCreationView: PostCreationView, shouldChangeTextIn range: NSRange, with text: String, for textView: UITextView) -> Bool {
        let textViewLength = textView.text.count + (text.count - range.length)
        
        presenter.updateLabelIfNeeded(postCreationView, for: textViewLength)

        return presenter.shouldUpdateTextView(for: textViewLength)
    }
    
}
