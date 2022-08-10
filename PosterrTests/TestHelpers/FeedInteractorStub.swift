//
//  FeedPresenterStub.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import Foundation
@testable import Posterr

class FeedInteractorStub: FeedInteractorProtocol {
    
    var output: FeedInteractorOutputProtocol?
    
    func getPosts(from: User?) {
        output?.getPostsSucceeded(with: [.dummy(), .repostDummy(), .quotePostDummy()])
    }
    
    func getPostCount(of: User, for: Date) {
        output?.getPostsCountSucceeded(with: 4)
    }
    
    func getMorePosts(from user: User?) {
        output?.getMorePostsSucceeded(with: [.dummy(), .repostDummy(), .quotePostDummy()])
    }
    
    func addNewPost(with: String, for: User) {
        output?.addNewPostSucceeded(with: .dummy())
    }
    
    func addRepost(of: Post, for: User) {
        output?.addRepostSucceeded(with: .repostDummy())
    }
    
    func addQuotePost(for: Post, with: String, by: User) {
        output?.addQuotePostSucceeded(with: .quotePostDummy())
    }
    
}
