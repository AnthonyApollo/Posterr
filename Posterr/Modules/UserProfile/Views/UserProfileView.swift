//
//  UserProfileView.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit
import SnapKit

final class UserProfileView: UIView {
    
    private lazy var infoView: UserInfoView = .init()
    
    private lazy var feedViewController: FeedViewController = {
        let interactor = FeedInteractor()
        let presenter = FeedPresenter(interactor: interactor)
        let viewController = FeedViewController(presenter: presenter)
        interactor.output = presenter
        presenter.view = viewController
        
        return viewController
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with user: UserEntity) {
        infoView.update(with: user)
    }
    
}

extension UserProfileView: CodableView {
    
    func configViews() {
        backgroundColor = .white
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
