//
//  UserProfileView.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

final class UserProfileView: UIView {
    
    private let user: DomainUser
    private lazy var infoView: UserInfoView = .init(user: user)
    weak var feedViewControllerDelegate: FeedViewControllerDelegate?
    
    private lazy var feedViewController: FeedViewController = {
        return FeedRouter.createModule(with: user, and: feedViewControllerDelegate)
    }()
    
    init(user: DomainUser, feedViewControllerDelegate: FeedViewControllerDelegate? = nil) {
        self.user = user
        self.feedViewControllerDelegate = feedViewControllerDelegate
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFeed() {
        feedViewController.updateUI()
    }
    
    func updateUserInfo() {
        infoView.update()
    }
    
}

extension UserProfileView: CodableView {
    
    func configViews() {
        backgroundColor = .systemBackground
    }
    
    func buildViews() {
        addSubviews(infoView, feedViewController.view)
    }
    
    func configConstraints() {
        infoView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
        
        feedViewController.view.snp.makeConstraints { make in
            make.leading.equalTo(infoView.snp.leading)
            make.top.equalTo(infoView.snp.bottom).offset(8)
            make.trailing.equalTo(infoView.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
}
