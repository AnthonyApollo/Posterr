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
        output?.getPostsSuccess(result: Post.dummies())
    }
    
}
