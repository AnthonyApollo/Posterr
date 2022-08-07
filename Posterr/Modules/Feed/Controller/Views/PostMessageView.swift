//
//  PostMessageView.swift
//  Posterr
//
//  Created by Anthony Apollo on 06/08/22.
//

import UIKit

final class PostMessageView: UIView {
    
    private let type: PostType
    
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
    
    init(type: PostType = .post) {
        self.type = type
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with post: Post) {
        authorUsernameLabel.text = post.author?.username
        
        if let message = post.message {
            messageLabel.text = message
        } else {
            messageLabel.removeFromSuperview()
        }
        
        setupViews()
    }
    
}

extension PostMessageView: CodableView {
    
    func configViews() {
        backgroundColor = type.messageViewBackgroundColor
        layer.cornerRadius = type.messageViewCornerRadius
    }
    
    func buildViews() {
        addSubviews(authorUsernameLabel, messageLabel)
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
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
}
