//
//  PostCountView.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

final class PostCountView: UIView {
    
    private var user: User
    private let type: PostType
    
    private lazy var countIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = type.icon
        imageView.tintColor = .label
        
        return imageView
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = getCountLabelText()
        
        return label
    }()
    
    init(user: User, type: PostType) {
        self.user = user
        self.type = type
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with user: User) {
        self.user = user
        countLabel.text = getCountLabelText()
    }
    
    private func getCountLabelText() -> String {
        switch type {
        case .post:
            return String(user.posts)
        case .repost:
            return String(user.reposts)
        case .quotePost:
            return String(user.quotePosts)
        }
    }
    
}

extension PostCountView: CodableView {
    
    func buildViews() {
        addSubviews(countIcon, countLabel)
    }
    
    func configConstraints() {
        countIcon.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.size.equalTo(24)
        }
        
        countLabel.snp.makeConstraints { make in
            make.leading.equalTo(countIcon.snp.trailing).offset(8)
            make.centerY.equalTo(countIcon.snp.centerY)
            make.trailing.equalToSuperview()
        }
    }
    
}
