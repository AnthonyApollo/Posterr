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
    
    func getPosts() {
        let result = appDataSource.getPosts()
        
        output?.getPostsSucceeded(with: result)
    }
    
    func addNewPost(for message: String) {
        appDataSource.addNewPost(for: message)
        
        output?.addNewPostSucceeded()
    }
    
}
