//
//  FeedInteractor.swift
//  Posterr
//
//  Created by Anthony Apollo on 04/08/22.
//

import Foundation

final class FeedInteractor: FeedInteractorProtocol {
    
    weak var output: FeedInteractorOutputProtocol?
    
    func getPosts() {
        output?.getPostsSuccess(result: DataManager.shared.posts())
    }
    
    func post(_ message: String) {
        DataManager.shared.post(message)
        DataManager.shared.saveContext()
        
        output?.postSuccess()
    }
    
}
