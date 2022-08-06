//
//  UserInfoView.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

final class UserInfoView: UIView {
    
    private let user: User
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = user.username
        label.numberOfLines = 1
     
        return label
    }()
    
    private lazy var joinDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date must be here"
        label.numberOfLines = 1
     
        return label
    }()
    
    private lazy var postCountView: PostCountView = .init(count: 0, type: .post)
    private lazy var repostCountView: PostCountView = .init(count: 0, type: .repost)
    private lazy var quotePostCountView: PostCountView = .init(count: 0, type: .quotePost)
    
    init(user: User) {
        self.user = user
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
