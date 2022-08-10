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
    
    private let requestLimit = 5
    private var requestOffset = 0
    private var didReachEndOfList = false
    
    init(appDataSource: AppDataSourceProtocol = DataManager.shared) {
        self.appDataSource = appDataSource
    }
    
    func getPosts(from user: User?) {
        requestOffset = 0
        didReachEndOfList = false
        
        appDataSource.getPosts(from: user, with: requestLimit, and: requestOffset) { [weak self] result in
            switch result {
            case .success(let posts):
                self?.controlPagination(with: posts.count)
                self?.output?.getPostsSucceeded(with: posts)
            case .failure(let error):
                self?.output?.operationFailed(with: error)
            }
        }
    }
    
    func getMorePosts(from user: User?) {
        guard !didReachEndOfList else { return }
        
        appDataSource.getPosts(from: user, with: requestLimit, and: requestOffset) { [weak self] result in
            switch result {
            case .success(let posts):
                self?.controlPagination(with: posts.count)
                self?.output?.getMorePostsSucceeded(with: posts)
            case .failure(let error):
                self?.output?.operationFailed(with: error)
            }
        }
    }
    
    private func controlPagination(with count: Int) {
        didReachEndOfList = count < 5
        requestOffset += count
    }
    
    func addNewPost(with message: String, for user: User) {
        appDataSource.addNewPost(with: message, for: user) { [weak self] result in
            switch result {
            case .success(let post):
                self?.output?.addNewPostSucceeded(with: post)
            case .failure(let error):
                self?.output?.operationFailed(with: error)
            }
        }
    }
    
    func addRepost(of post: DomainPost, for user: User) {
        appDataSource.addRepost(of: post, for: user) { [weak self] result in
            switch result {
            case .success(let post):
                self?.output?.addRepostSucceeded(with: post)
                break
            case .failure(let error):
                self?.output?.operationFailed(with: error)
            }
        }
    }
    
    func addQuotePost(for post: DomainPost, with message: String, by user: User) {
        appDataSource.addQuotePost(for: post, with: message, by: user) { [weak self] result in
            switch result {
            case .success(let post):
                self?.output?.addQuotePostSucceeded(with: post)
                break
            case .failure(let error):
                self?.output?.operationFailed(with: error)
            }
        }
    }
    
}
