//
//  PostCreationView.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

class PostCreationView: UIView {
    
    // TODO: Add placeholder text
    private lazy var textView: UITextView = {
        .init()
    }()
    
    private lazy var remainingCharactersLabel: UILabel = {
        let label = UILabel()
        label.text = "777"
        
        return label
    }()
    
    private lazy var postButton: UIButton = {
        let button = UIButton()
        button.setTitle("Post", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        
        return button
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PostCreationView: CodableView {
    
    func configViews() {
        layer.cornerRadius = 5
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.separator.cgColor
    }
    
    func buildViews() {
        addSubviews(textView, remainingCharactersLabel, postButton)
    }
    
    func configConstraints() {
        textView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        remainingCharactersLabel.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.bottom.equalToSuperview()
        }
        
        postButton.snp.makeConstraints { make in
            make.top.equalTo(remainingCharactersLabel.snp.top)
            make.trailing.equalToSuperview().inset(8)
            make.bottom.equalToSuperview()
        }
    }
    
    
}
