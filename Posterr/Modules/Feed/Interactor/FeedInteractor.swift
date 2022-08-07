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
        let result = appDataSource.getPosts(from: user)
        
        output?.getPostsSucceeded(with: result)
    }
    
    func addNewPost(with message: String, for user: User) {
        appDataSource.addNewPost(with: message, for: user)
        
        output?.addNewPostSucceeded()
    }
    
    func addRepost(of post: Post, for user: User) {
        appDataSource.addRepost(of: post, for: user)
        
        output?.addRepostSucceeded()
    }
    
}
