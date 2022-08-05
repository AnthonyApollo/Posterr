//
//  FeedPresenter.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import Foundation

final class FeedPresenter: FeedPresenterProtocol {
    
    weak var view: FeedViewProtocol?
    private let interactor: FeedInteractorProtocol
    
    let tableViewManager = PostsTableViewManager()
    
    init(interactor: FeedInteractorProtocol) {
        self.interactor = interactor
    }
    
    func setup() {
        interactor.getPosts()
    }
    
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    
    func getPostsSuccess(result: [Post]) {
        tableViewManager.posts = result
    }
    
}
