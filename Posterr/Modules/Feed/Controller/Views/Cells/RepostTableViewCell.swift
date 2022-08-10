//
//  RepostTableViewCell.swift
//  Posterr
//
//  Created by Anthony Apollo on 06/08/22.
//

import UIKit
import Rswift

final class RepostTableViewCell: UITableViewCell, PostCell {
    
    static let reuseIdentifier: ReuseIdentifier<RepostTableViewCell> = ReuseIdentifier(identifier: "RepostTableViewCell")
    
    weak var delegate: PostTableViewCellDelegate?
    private var post: DomainPost?
    
    private lazy var postMessageView: PostMessageView = .init()
    private lazy var repostMessageView: PostMessageView = .init(type: .repost)
    private lazy var postReplyMenu: PostReplyMenu = .init(with: self)
    
    func setup(with post: DomainPost) {
        self.post = post
        postMessageView.setup(with: post)
        repostMessageView.setup(with: post.originalPost ?? post)
        
        setupViews()
    }
    
}

extension RepostTableViewCell: CodableView {
    
    func configViews() {
        backgroundColor = .clear
    }
    
    func buildViews() {
        contentView.addSubviews(postMessageView, repostMessageView, postReplyMenu)
    }
    
    func configConstraints() {
        postMessageView.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        repostMessageView.snp.makeConstraints { make in
            make.leading.equalTo(postMessageView.snp.leading).offset(8)
            make.top.equalTo(postMessageView.snp.bottom).offset(8)
            make.trailing.equalTo(postMessageView.snp.trailing).inset(8)
        }
        
        postReplyMenu.snp.makeConstraints { make in
            make.top.equalTo(repostMessageView.snp.bottom).offset(8)
            make.trailing.equalTo(postMessageView.snp.trailing)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
}

extension RepostTableViewCell: PostReplyMenuDelegate {
    
    func didTapRepost() {
        guard let post = post else { return }
        
        delegate?.didTapRepost(for: post)
    }
    
    func didTapQuote() {
        guard let post = post else { return }
        
        delegate?.didTapQuote(for: post)
    }
    
}
