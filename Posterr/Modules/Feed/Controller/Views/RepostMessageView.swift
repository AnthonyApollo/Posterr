//
//  RepostMessageView.swift
//  Posterr
//
//  Created by Anthony Apollo on 06/08/22.
//

import UIKit

final class RepostMessageView: UIView {
    
    private lazy var postMessageView: PostMessageView = .init()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with post: Post) {
        postMessageView.setup(with: post)
    }
    
}

extension RepostMessageView: CodableView {
    
    func configViews() {
        self.backgroundColor = .systemGray6
        self.layer.cornerRadius = 5
    }
    
    func buildViews() {
        addSubview(postMessageView)
    }
    
    func configConstraints() {
        postMessageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
