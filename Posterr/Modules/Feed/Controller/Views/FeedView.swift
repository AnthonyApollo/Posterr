//
//  FeedView.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import UIKit
import SnapKit

final class FeedView: UIView {
    
    private let shouldDisplayTitle: Bool
    
    private lazy var appTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Posterr"
        label.font = .boldSystemFont(ofSize: 36)
        label.numberOfLines = 1
     
        return label
    }()
    
    lazy var postCreationView: PostCreationView = .init()
    
    lazy var postsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.showsVerticalScrollIndicator = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.reuseIdentifier.identifier)
        tableView.register(RepostTableViewCell.self, forCellReuseIdentifier: RepostTableViewCell.reuseIdentifier.identifier)
        tableView.register(QuoteTableViewCell.self, forCellReuseIdentifier: QuoteTableViewCell.reuseIdentifier.identifier)
        
        return tableView
    }()
    
    init(shouldHideTitle: Bool = true) {
        self.shouldDisplayTitle = !shouldHideTitle
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload() {
        postsTableView.reloadData()
    }
    
    func setupQuote(of post: Post) {
        postCreationView.setupQuote(of: post)
    }
    
    func insertPosts(at indexPaths: [IndexPath]) {
        postsTableView.insertRows(at: indexPaths, with: .right)
    }
    
    func scroll(to indexPath: IndexPath) {
        postsTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
    
    func updateRemainingCharacters(with count: String?) {
        postCreationView.updateRemainingCharacters(with: count)
    }
    
    func enablePostButton() {
        postCreationView.enablePostButton()
    }
    
    func disablePostButton() {
        postCreationView.disablePostButton()
    }
    
}

extension FeedView: CodableView {
    
    func configViews() {
        backgroundColor = .systemBackground
    }
    
    func buildViews() {
        if shouldDisplayTitle {
            addSubview(appTitleLabel)
        }
        addSubviews(postCreationView, postsTableView)
    }
    
    func configConstraints() {
        if shouldDisplayTitle {
            appTitleLabel.snp.makeConstraints { make in
                make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(8)
                make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
                make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(8)
            }
            
            postCreationView.snp.makeConstraints { make in
                make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(8)
                make.top.equalTo(appTitleLabel.snp.bottom).offset(8)
                make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(8)
            }
        } else {
            postCreationView.snp.makeConstraints { make in
                make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(8)
                make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
                make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(8)
            }
        }
        
        postsTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(postCreationView.snp.bottom).offset(8)
        }
    }
    
}
