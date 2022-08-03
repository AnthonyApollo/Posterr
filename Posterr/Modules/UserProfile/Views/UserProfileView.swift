//
//  UserProfileView.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

class UserProfileView: UIView {
    
    private let user: User
    
    private lazy var infoView: UserInfoView = {
        .init(user: user)
    }()
    
    init(user: User) {
        self.user = user
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UserProfileView: CodableView {
    
    func buildViews() {
        addSubview(infoView)
    }
    
    func configConstraints() {
        infoView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
    
    
}
