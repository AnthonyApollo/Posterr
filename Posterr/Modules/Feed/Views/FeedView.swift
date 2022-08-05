//
//  FeedView.swift
//  Posterr
//
//  Created by Anthony Apollo on 02/08/22.
//

import UIKit
import SnapKit

class FeedView: UIView {
    
    lazy var postCreationView: PostCreationView = .init()
    
    lazy var postsTableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostTableViewCell")
        
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reload() {
        postsTableView.reloadData()
    }
    
}

extension FeedView: CodableView {
    
    func configViews() {
        backgroundColor = .white
    }
    
    func buildViews() {
        addSubviews(postCreationView, postsTableView)
    }
    
    func configConstraints() {
        postCreationView.snp.makeConstraints { make in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(8)
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(8)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).inset(8)
        }
        
        postsTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(postCreationView.snp.bottom).offset(8)
        }
    }
    
}
