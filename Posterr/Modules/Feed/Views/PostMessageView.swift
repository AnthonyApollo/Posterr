//
//  PostMessageView.swift
//  Posterr
//
//  Created by Anthony Apollo on 06/08/22.
//

import UIKit

final class PostMessageView: UIView {
    
    private lazy var authorUsernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with post: Post) {
        authorUsernameLabel.text = post.author?.username
        messageLabel.text = post.message
        
        setupViews()
    }
    
}

extension PostMessageView: CodableView {
    
    func buildViews() {
        addSubviews(authorUsernameLabel, messageLabel)
    }
    
    func configConstraints() {
        authorUsernameLabel.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        
        messageLabel.snp.makeConstraints { make in
            make.leading.equalTo(authorUsernameLabel.snp.leading)
            make.top.equalTo(authorUsernameLabel.snp.bottom).offset(8)
            make.trailing.equalTo(authorUsernameLabel.snp.trailing)
            make.bottom.equalToSuperview()
        }
    }
    
}
