//
//  QuoteTableViewCell.swift
//  Posterr
//
//  Created by Anthony Apollo on 06/08/22.
//

import UIKit
import Rswift

final class QuoteTableViewCell: UITableViewCell, PostCell {
    
    static let reuseIdentifier: ReuseIdentifier<QuoteTableViewCell> = ReuseIdentifier(identifier: "QuoteTableViewCell")
    
    weak var delegate: PostTableViewCellDelegate?
    private var post: DomainPost?
    
    private lazy var quoteMessageView: PostMessageView = .init(type: .quotePost)
    private lazy var postMessageView: PostMessageView = .init()
    private lazy var postReplyMenu: PostReplyMenu = .init(with: self)
    
    func setup(with post: DomainPost) {
        self.post = post
        postMessageView.setup(with: post)
        quoteMessageView.setup(with: post.quotePost ?? post)
        
        setupViews()
    }
    
}

extension QuoteTableViewCell: CodableView {
    
    func configViews() {
        backgroundColor = .clear
    }
    
    func buildViews() {
        contentView.addSubviews(quoteMessageView, postMessageView, postReplyMenu)
    }
    
    func configConstraints() {
        quoteMessageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        postMessageView.snp.makeConstraints { make in
            make.top.equalTo(quoteMessageView.snp.bottom).offset(8)
            make.leading.equalTo(quoteMessageView.snp.leading)
            make.trailing.equalTo(quoteMessageView.snp.trailing)
        }
        
        postReplyMenu.snp.makeConstraints { make in
            make.top.equalTo(postMessageView.snp.bottom).offset(8)
            make.trailing.equalTo(postMessageView.snp.trailing)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
}

extension QuoteTableViewCell: PostReplyMenuDelegate {
    
    func didTapRepost() {
        guard let post = post else { return }
        
        delegate?.didTapRepost(for: post)
    }
    
    func didTapQuote() {
        guard let post = post else { return }
        
        delegate?.didTapQuote(for: post)
    }
    
}
