//
//  PostCreationView.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

final class PostCreationView: UIView {
    
    weak var delegate: PostCreationViewDelegate?
    private var post: Post?
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "What's on your mind?"
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 1
     
        return label
    }()
    
    private lazy var quoteMessageView: PostMessageView = .init(type: .quotePost, delegate: self, shouldDisplayCloseButton: true)
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        
        return textView
    }()
    
    private lazy var remainingCharactersLabel: UILabel = .init()
    
    private lazy var postButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTouchPostButton), for: .touchUpInside)
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateRemainingCharacters(with count: String?) {
        remainingCharactersLabel.text = count
    }
    
    func enablePostButton() {
        postButton.setImage(.init(systemName: "paperplane.circle.fill"), for: .normal)
        postButton.imageView?.tintColor = nil
        postButton.isUserInteractionEnabled = true
    }
    
    func disablePostButton() {
        postButton.setImage(.init(systemName: "paperplane.circle"), for: .normal)
        postButton.imageView?.tintColor = .systemGray
        postButton.isUserInteractionEnabled = false
    }
    
    @objc func didTouchPostButton() {
        if !textView.text.isBlankOrEmpty {
            post(message: textView.text)
            clear()
            setupViews()
        }
    }
    
    private func clear() {
        textView.clear()
        updateRemainingCharacters(with: nil)
        removeMessageView()
    }
    
    private func removeMessageView() {
        post = nil
        quoteMessageView.removeFromSuperview()
    }
    
    func post(message: String) {
        guard let post = post else {
            delegate?.didPost(message)
            return
        }

        delegate?.didPost(message, with: post)
    }
    
    func setupQuote(of post: Post) {
        self.post = post
        quoteMessageView.setup(with: post)
        addSubview(quoteMessageView)
        configQuoteConstraints()
    }
    
    private func configQuoteConstraints() {
        quoteMessageView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        
        textView.snp.remakeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(quoteMessageView.snp.bottom).offset(8)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.height.equalTo(50)
        }
    }
    
}
    
extension PostCreationView: CodableView {
    
    func configViews() {
        backgroundColor = .white
        layer.cornerRadius = 5
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.separator.cgColor
        layer.shadowColor = UIColor.systemGray5.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 2, height: 2)
        layer.shadowRadius = 5
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        disablePostButton()
    }
    
    func buildViews() {
        addSubviews(titleLabel, textView, remainingCharactersLabel, postButton)
    }
    
    func configConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
        
        textView.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.trailing.equalTo(titleLabel.snp.trailing)
            make.height.equalTo(50)
        }
        
        remainingCharactersLabel.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview()
        }
        
        postButton.snp.makeConstraints { make in
            make.top.equalTo(remainingCharactersLabel.snp.top)
            make.trailing.bottom.equalToSuperview().inset(8)
        }
        
        postButton.imageView?.snp.makeConstraints { make in
            make.size.equalTo(36)
        }
    }
    
}

extension PostCreationView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textLength = textView.text.count + (text.count - range.length)
        return delegate?.shouldUpdateTextView(for: textLength) ?? false
    }
    
}

extension PostCreationView: PostMessageViewDelegate {
    
    func didTouchCloseButton() {
        removeMessageView()
        setupViews()
    }
    
}
