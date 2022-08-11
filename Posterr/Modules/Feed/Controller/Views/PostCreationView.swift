//
//  PostCreationView.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

protocol PostCreationViewDelegate: AnyObject {
    
    func shouldUpdateTextView(for: Int) -> Bool
    func didPost(_: String)
    func didPost(_: String, with: Post)
    
}

final class PostCreationView: UIView {
    
    weak var delegate: PostCreationViewDelegate?
    private var post: Post?
    
    internal private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.textViewTitle()
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 1
     
        return label
    }()
    
    internal private(set) lazy var quoteMessageView: PostMessageView = .init(type: .quotePost, delegate: self, shouldDisplayCloseButton: true)
    
    internal private(set) lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.font = .systemFont(ofSize: 16)
        
        return textView
    }()
    
    internal private(set) lazy var remainingCharactersLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray
        
        return label
    }()
    
    internal private(set) lazy var postButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(didTouchPostButton), for: .touchUpInside)
        button.setImage(.init(systemName: SystemIcons.sendIconDisabled()), for: .disabled)
        button.setImage(.init(systemName: SystemIcons.sendIconEnabled()), for: .normal)
        
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
        postButton.imageView?.tintColor = nil
        postButton.isEnabled = true
    }
    
    func disablePostButton() {
        postButton.imageView?.tintColor = .systemGray
        postButton.isEnabled = false
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
    
    @objc private func wasTapped() {
        textView.becomeFirstResponder()
    }
    
}
    
extension PostCreationView: CodableView {
    
    func configViews() {
        backgroundColor = .systemBackground
        setThinBorder()
        setLightShadow()
        disablePostButton()
        
        isUserInteractionEnabled = true
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(wasTapped))
        addGestureRecognizer(recognizer)
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
            make.trailing.bottom.equalToSuperview().inset(16)
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
