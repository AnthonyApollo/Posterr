//
//  CodableView.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import UIKit

protocol CodableView: UIView {
    
    func setupViews()
    
    func configViews()
    func buildViews()
    func configConstraints()
    
}

extension CodableView {
    
    func setupViews() {
        configViews()
        buildViews()
        configConstraints()
    }
    
}
