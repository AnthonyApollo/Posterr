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
        output?.getPostsSuccess(result: appDataSource.getPosts())
    }
    
    func post(_ message: String) {
        appDataSource.post(message)
        
        output?.postSuccess()
    }
    
}
