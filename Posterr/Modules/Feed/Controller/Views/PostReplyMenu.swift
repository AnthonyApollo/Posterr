//
//  PostReplyMenu.swift
//  Posterr
//
//  Created by Anthony Apollo on 06/08/22.
//

import UIKit

final class PostReplyMenu: UIView {
    
    weak var delegate: PostReplyMenuDelegate?
    
    private lazy var repostButton: UIButton = {
        let button = UIButton()
        button.setImage(PostType.repost.icon, for: .normal)
        
        button.addTarget(self, action: #selector(didTouchRepostButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var quoteButton: UIButton = {
        let button = UIButton()
        button.setImage(PostType.quotePost.icon, for: .normal)
        button.addTarget(self, action: #selector(didTouchQuoteButton), for: .touchUpInside)
        
        return button
    }()
    
    init(with delegate: PostReplyMenuDelegate) {
        self.delegate = delegate
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTouchRepostButton() {
        delegate?.didTapRepost()
    }
    
    @objc private func didTouchQuoteButton() {
        delegate?.didTapQuote()
    }
    
}

extension PostReplyMenu: CodableView {
    
    func buildViews() {
        addSubviews(repostButton, quoteButton)
    }
    
    func configConstraints() {
        repostButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().inset(16)
        }
        
        quoteButton.snp.makeConstraints { make in
            make.top.equalTo(repostButton.snp.top)
            make.trailing.equalTo(repostButton.snp.leading).offset(-32)
            make.bottom.equalTo(repostButton.snp.bottom)
            make.leading.equalToSuperview()
        }
        
        repostButton.imageView?.snp.makeConstraints { make in
            make.size.equalTo(28)
        }
        
        quoteButton.imageView?.snp.makeConstraints { make in
            make.size.equalTo(28)
        }
        
    }
    
}
