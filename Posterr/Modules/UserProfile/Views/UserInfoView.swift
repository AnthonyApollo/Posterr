//
//  UserInfoView.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

final class UserInfoView: UIView {
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
     
        return label
    }()
    
    private lazy var joinDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date must be here"
        label.numberOfLines = 1
     
        return label
    }()
    
    private lazy var postCountView: PostCountView = {
        .init(type: .post)
    }()
    
    private lazy var repostCountView: PostCountView = {
        .init(type: .repost)
    }()
    
    private lazy var quotePostCountView: PostCountView = {
        .init(type: .quotePost)
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with user: UserEntity) {
        usernameLabel.text = user.username
        postCountView.update(with: 0)
        repostCountView.update(with: 0)
        quotePostCountView.update(with: 0)
    }
    
}

extension UserInfoView: CodableView {
    
    func buildViews() {
        addSubviews(usernameLabel, joinDateLabel, postCountView, repostCountView, quotePostCountView)
    }
    
    func configConstraints() {
        usernameLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        joinDateLabel.snp.makeConstraints { make in
            make.leading.equalTo(usernameLabel.snp.leading)
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.trailing.equalTo(usernameLabel.snp.trailing)
        }
        
        postCountView.snp.makeConstraints { make in
            make.leading.equalTo(usernameLabel.snp.leading)
            make.top.equalTo(joinDateLabel.snp.bottom).offset(8)
            make.trailing.equalTo(usernameLabel.snp.trailing)
        }
        
        repostCountView.snp.makeConstraints { make in
            make.leading.equalTo(usernameLabel.snp.leading)
            make.top.equalTo(postCountView.snp.bottom).offset(8)
            make.trailing.equalTo(usernameLabel.snp.trailing)
        }
        
        quotePostCountView.snp.makeConstraints { make in
            make.leading.equalTo(usernameLabel.snp.leading)
            make.top.equalTo(repostCountView.snp.bottom).offset(8)
            make.trailing.equalTo(usernameLabel.snp.trailing)
            make.bottom.equalToSuperview()
        }
    }
    
}
