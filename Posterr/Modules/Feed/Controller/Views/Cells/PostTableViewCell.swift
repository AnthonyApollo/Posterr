//
//  PostTableViewCell.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

final class PostTableViewCell: UITableViewCell, PostCell {
    
    weak var delegate: PostTableViewCellDelegate?
    private var post: Post?
    
    private lazy var postMessageView: PostMessageView = .init()
    private lazy var postReplyMenu: PostReplyMenu = .init(with: self)
    
    func setup(with post: Post) {
        self.post = post
        postMessageView.setup(with: post)
        
        setupViews()
    }
    
}

extension PostTableViewCell: CodableView {
    
    func configViews() {
        backgroundColor = .white
    }
    
    func buildViews() {
        contentView.addSubviews(postMessageView, postReplyMenu)
    }
    
    func configConstraints() {
        postMessageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        postReplyMenu.snp.makeConstraints { make in
            make.top.equalTo(postMessageView.snp.bottom).offset(8)
            make.trailing.equalTo(postMessageView.snp.trailing)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
}

extension PostTableViewCell: PostReplyMenuDelegate {
    
    func didTapRepost() {
        guard let post = post else { return }
        
        delegate?.didTapRepost(for: post)
    }
    
    func didTapQuote() {
        guard let post = post else { return }
        
        delegate?.didTapQuote(for: post)
    }
    
}
