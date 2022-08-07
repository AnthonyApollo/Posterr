//
//  FeedInteractor.swift
//  Posterr
//
//  Created by Anthony Apollo on 04/08/22.
//

import Foundation

final class FeedInteractor: FeedInteractorProtocol {
    
    private let appDataSource: AppDataSourceProtocol
    weak var output: FeedInteractorOutputProtocol?
    
    init(appDataSource: AppDataSourceProtocol = DataManager.shared) {
        self.appDataSource = appDataSource
    }
    
    func getPosts(from user: User?) {
        appDataSource.getPosts(from: user) { [weak self] result in
            switch result {
            case .success(let posts):
                self?.output?.getPostsSucceeded(with: posts)
            case .failure(let error):
                self?.output?.operationFailed(with: error)
            }
        }
    }
    
    func addNewPost(with message: String, for user: User) {
        appDataSource.addNewPost(with: message, for: user) { [weak self] result in
            switch result {
            case .success:
                self?.output?.addNewPostSucceeded()
            case .failure(let error):
                self?.output?.operationFailed(with: error)
            }
        }
        
        
    }
    
    func addRepost(of post: Post, for user: User) {
        appDataSource.addRepost(of: post, for: user) { [weak self] result in
            switch result {
            case .success:
                self?.output?.addRepostSucceeded()
            case .failure(let error):
                self?.output?.operationFailed(with: error)
            }
        }
    }
    
    func addQuotePost(for post: Post, with message: String, by user: User) {
        appDataSource.addQuotePost(for: post, with: message, by: user) { [weak self] result in
            switch result {
            case .success:
                self?.output?.addQuotePostSucceeded()
            case .failure(let error):
                self?.output?.operationFailed(with: error)
            }
        }
    }
    
}
