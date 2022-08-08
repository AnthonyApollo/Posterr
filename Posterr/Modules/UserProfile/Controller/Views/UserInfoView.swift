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
        label.font = .boldSystemFont(ofSize: 36)
        label.numberOfLines = 1
     
        return label
    }()
    
    private lazy var joinDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Joined \(user.joinedDate?.formattedString ?? "")"
        label.textColor = .lightGray
        label.numberOfLines = 1
     
        return label
    }()
    
    private lazy var countStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.spacing = 8
        
        return stackView
    }()
    
    private lazy var postCountView: PostCountView = .init(user: user, type: .post)
    private lazy var repostCountView: PostCountView = .init(user: user, type: .repost)
    private lazy var quotePostCountView: PostCountView = .init(user: user, type: .quotePost)
    
    init(user: User) {
        self.user = user
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update() {
        postCountView.update()
        repostCountView.update()
        quotePostCountView.update()
    }
    
}

extension UserInfoView: CodableView {
    
    func buildViews() {
        addSubviews(usernameLabel, joinDateLabel, countStackView)
        countStackView.addArrangedSubview(postCountView)
        countStackView.addArrangedSubview(quotePostCountView)
        countStackView.addArrangedSubview(repostCountView)
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
        
        countStackView.snp.makeConstraints { make in
            make.leading.equalTo(usernameLabel.snp.leading)
            make.top.equalTo(joinDateLabel.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(8)
        }
    }
    
}
