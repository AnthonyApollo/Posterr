//
//  PostTableViewCell.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

class PostTableViewCell: UITableViewCell {
    
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
    
    func setup(with post: Post) {
        self.post = post
        
        setupViews()
    }
    
}

extension PostTableViewCell: CodableView {
    
    func configViews() {
        backgroundColor = .white
    }
    
    func buildViews() {
        addSubview(authorUsernameLabel)
        addSubview(messageLabel)
    }
    
    func configConstraints() {
        
        authorUsernameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(authorUsernameLabel.snp.bottom).offset(8)
            make.trailing.bottom.equalToSuperview().inset(8)
        }
    }
    
}
