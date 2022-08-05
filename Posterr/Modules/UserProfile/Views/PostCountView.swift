//
//  PostCountView.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

final class PostCountView: UIView {
    
    let type: PostType
    
    private lazy var countIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = type.icon
        
        return imageView
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    init(type: PostType) {
        self.type = type
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with count: Int) {
        countLabel.text = String(count)
    }
    
}

extension PostCountView: CodableView {
    
    func buildViews() {
        addSubviews(countIcon, countLabel)
    }
    
    func configConstraints() {
        countIcon.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.height.equalTo(24)
        }
        
        countLabel.snp.makeConstraints { make in
            make.leading.equalTo(countIcon.snp.trailing).offset(8)
            make.centerY.equalTo(countIcon.snp.centerY)
        }
    }
    
}

enum PostType {
    
    case post, repost, quotePost
    
    var icon: UIImage {
        switch self {
        case .post:
            //TODO: Remove force unwrap
            return UIImage(systemName: "text.bubble")!
        case .repost:
            return UIImage(systemName: "bubble.left.and.bubble.right")!
        case .quotePost:
            return UIImage(systemName: "quote.bubble")!
        }
    }
    
}
