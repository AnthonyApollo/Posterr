//
//  UserProfileView.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

class UserProfileView: UIView {
    
    private var user: User
    private lazy var infoView: UserInfoView = .init(user: user)
    private let feedRouter: FeedRouterProtocol
    weak var feedViewControllerDelegate: FeedViewControllerDelegate?
    
    private lazy var feedViewController: FeedViewProtocol = {
        return feedRouter.createModule(with: user, and: feedViewControllerDelegate)
    }()
    
    init(user: User, feedViewControllerDelegate: FeedViewControllerDelegate? = nil, feedRouter: FeedRouterProtocol) {
        self.user = user
        self.feedViewControllerDelegate = feedViewControllerDelegate
        self.feedRouter = feedRouter
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFeed() {
        feedViewController.updateUI()
    }
    
    func updateUserInfo(with user: User) {
        self.user = user
        infoView.update(with: user)
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
