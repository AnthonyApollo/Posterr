//
//  FeedView.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import UIKit

class FeedView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FeedView: CodableView {
    
    func configViews() {
        backgroundColor = .blue
    }
    
    func buildViews() {
        // TODO: Add implementation
    }
    
    func configConstraints() {
        // TODO: Add implementation
    }
    
}
