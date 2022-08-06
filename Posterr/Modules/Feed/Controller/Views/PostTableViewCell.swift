//
//  PostTableViewCell.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

final class PostTableViewCell: UITableViewCell {
    
    weak var delegate: PostTableViewCellDelegate?
    private var post: Post?
    
    private lazy var postMessageView: PostMessageView = .init()
    
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
        postMessageView.setup(with: post)
        
        setupViews()
    }
    
    @objc func didTouchRepostButton() {
        guard let post = post else { return }
        
        delegate?.didTapRepost(for: post)
    }
    
    @objc func didTouchQuoteButton() {
        guard let post = post else { return }
        
        delegate?.didTapQuote(for: post)
    }
    
}

extension PostTableViewCell: CodableView {
    
    func configViews() {
        backgroundColor = .white
    }
    
    func buildViews() {
        contentView.addSubviews(postMessageView, repostButton, quoteButton)
    }
    
    func configConstraints() {
        
        postMessageView.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        repostButton.snp.makeConstraints { make in
            make.top.equalTo(postMessageView.snp.bottom).offset(8)
            make.trailing.equalTo(postMessageView.snp.trailing)
            make.bottom.equalToSuperview().inset(8)
        }
        
        quoteButton.snp.makeConstraints { make in
            make.top.equalTo(repostButton.snp.top)
            make.trailing.equalTo(repostButton.snp.leading).offset(-8)
            make.bottom.equalTo(repostButton.snp.bottom)
        }
    }
    
}
