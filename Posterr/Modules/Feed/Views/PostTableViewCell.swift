//
//  PostTableViewCell.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

final class PostTableViewCell: UITableViewCell {
    
    private var post: Post?
    
    private lazy var authorUsernameLabel: UILabel = {
        let label = UILabel()
        label.text = post?.author.username ?? ""
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = post?.message ?? ""
        label.numberOfLines = 0
        
        return label
    }()
    
    private lazy var repostButton: UIButton = {
        let button = UIButton()
        button.setTitle("Repost", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        
        button.addTarget(self, action: #selector(didTouchRepostButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var quoteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Quote", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        
        button.addTarget(self, action: #selector(didTouchQuoteButton), for: .touchUpInside)
        
        return button
    }()
    
    func setup(with post: Post) {
        self.post = post
        
        setupViews()
    }
    
    @objc func didTouchRepostButton() {
        print("repost")
    }
    
    @objc func didTouchQuoteButton() {
        print("quote")
    }
    
}

extension PostTableViewCell: CodableView {
    
    func configViews() {
        backgroundColor = .white
    }
    
    func buildViews() {
        contentView.addSubviews(authorUsernameLabel, messageLabel, repostButton, quoteButton)
    }
    
    func configConstraints() {
        
        authorUsernameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.leading.equalTo(authorUsernameLabel.snp.leading)
            make.top.equalTo(authorUsernameLabel.snp.bottom).offset(8)
            make.trailing.equalTo(authorUsernameLabel.snp.trailing)
        }
        
        repostButton.snp.makeConstraints { make in
            make.top.equalTo(messageLabel.snp.bottom).offset(8)
            make.trailing.equalTo(authorUsernameLabel.snp.trailing)
            make.bottom.equalToSuperview().inset(8)
        }
        
        quoteButton.snp.makeConstraints { make in
            make.top.equalTo(repostButton.snp.top)
            make.trailing.equalTo(repostButton.snp.leading).offset(-8)
            make.bottom.equalTo(repostButton.snp.bottom)
        }
        
    }
    
}
