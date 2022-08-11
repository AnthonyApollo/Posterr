//
//  FeedInteractorSpy.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import Foundation
@testable import Posterr

class FeedInteractorSpy: FeedInteractorProtocol {
    
    var output: FeedInteractorOutputProtocol?
    
    var isGetPostsCalled = false
    var isGetPostCountCalled = false
    var isGetMorePostsCalled = false
    var isAddNewPostCalled = false
    var isAddRepostCalled = false
    var isAddQuotePostCalled = false
    
    var pushedUser: User?
    var pushedDate: Date?
    var pushedMessage: String?
    var pushedPost: Post?
    
    func getPosts(from user: User?) {
        pushedUser = user
        isGetPostsCalled = true
    }
    
    func getPostCount(of user: User, for date: Date) {
        pushedUser = user
        pushedDate = date
        isGetPostCountCalled = true
    }
    
    func getMorePosts(from user: User?) {
        pushedUser = user
        isGetMorePostsCalled = true
    }
    
    func addNewPost(with message: String, for user: User) {
        pushedMessage = message
        pushedUser = user
        isAddNewPostCalled = true
    }
    
    func addRepost(of post: Post, for user: User) {
        pushedPost = post
        pushedUser = user
        isAddRepostCalled = true
    }
    
    func addQuotePost(for post: Post, with message: String, by user: User) {
        pushedPost = post
        pushedMessage = message
        pushedUser = user
        isAddQuotePostCalled = true
    }
    
}
