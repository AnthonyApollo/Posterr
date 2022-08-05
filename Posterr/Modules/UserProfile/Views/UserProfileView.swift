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
    private let tableViewManager: PostsTableViewManager
    
    private lazy var infoView: UserInfoView = {
        .init(user: user)
    }()
    
    private lazy var userPostsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = tableViewManager
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        
        return tableView
    }()
    
    init(user: User, tableViewManager: PostsTableViewManager) {
        self.user = user
        self.tableViewManager = tableViewManager
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension UserProfileView: CodableView {
    
    func buildViews() {
        addSubviews(infoView, userPostsTableView)
    }
    
    func configConstraints() {
        infoView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing)
        }
        
        userPostsTableView.snp.makeConstraints { make in
            make.leading.equalTo(infoView.snp.leading)
            make.top.equalTo(infoView.snp.bottom).offset(8)
            make.trailing.equalTo(infoView.snp.trailing)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    
}
