//
//  FeedInteractor.swift
//  Posterr
//
//  Created by Anthony Apollo on 04/08/22.
//

import Foundation

final class FeedInteractor: FeedInteractorProtocol {
    
    private let dataManager: DataManagerProtocol
    weak var output: FeedInteractorOutputProtocol?
    
    init(dataManager: DataManagerProtocol = DataManager.shared) {
        self.dataManager = dataManager
    }
    
    func getPosts() {
        output?.getPostsSuccess(result: DataManager.shared.posts())
    }
    
    func post(_ message: String) {
        dataManager.post(message)
        dataManager.saveContext()
        
        output?.postSuccess()
    }
    
}
