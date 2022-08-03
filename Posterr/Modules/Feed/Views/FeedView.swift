//
//  FeedView.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import UIKit
import SnapKit

class FeedView: UIView {
    
    private let tableViewManager: PostsTableViewManager
    
    private lazy var postsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.dataSource = tableViewManager
        tableView.delegate = tableViewManager
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        
        return tableView
    }()
    
    init(tableViewManager: PostsTableViewManager) {
        self.tableViewManager = tableViewManager
        
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
        backgroundColor = .white
    }
    
    func buildViews() {
        addSubview(postsTableView)
    }
    
    func configConstraints() {
        postsTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
