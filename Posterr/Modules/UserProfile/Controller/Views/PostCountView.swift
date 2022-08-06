//
//  PostCountView.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

final class PostCountView: UIView {
    
    private let count: Int
    private let type: PostType
    
    private lazy var countIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = type.icon
        
        return imageView
    }()
    
    private lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = String(count)
        
        return label
    }()
    
    init(count: Int, type: PostType) {
        self.count = count
        self.type = type
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
