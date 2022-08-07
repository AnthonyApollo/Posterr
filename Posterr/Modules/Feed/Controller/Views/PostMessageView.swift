//
//  PostMessageView.swift
//  Posterr
//
//  Created by Anthony Apollo on 06/08/22.
//

import UIKit

final class PostMessageView: UIView {
    
    weak var delegate: PostMessageViewDelegate?
    private let type: PostType
    private let shouldDisplayCloseButton: Bool
    
    private lazy var firstRowStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private lazy var authorUsernameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        
        button.addTarget(self, action: #selector(didTouchCloseButton), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        
        return label
    }()
    
    init(type: PostType = .post, delegate: PostMessageViewDelegate? = nil, shouldDisplayCloseButton: Bool = false) {
        self.type = type
        self.delegate = delegate
        self.shouldDisplayCloseButton = shouldDisplayCloseButton
        
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
    
    @objc private func didTouchCloseButton() {
        delegate?.didTouchCloseButton()
    }
    
}

extension PostMessageView: CodableView {
    
    func configViews() {
        backgroundColor = type.messageViewBackgroundColor
        layer.cornerRadius = type.messageViewCornerRadius
    }
    
    func buildViews() {
        addSubviews(firstRowStackView, messageLabel)
        firstRowStackView.addArrangedSubview(authorUsernameLabel)
        
        if type == .quotePost && shouldDisplayCloseButton {
            firstRowStackView.addArrangedSubview(closeButton)
        }
    }
    
    func configConstraints() {
        firstRowStackView.snp.makeConstraints { make in
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
