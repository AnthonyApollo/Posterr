//
//  AppDataSourceStub.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

import Foundation
@testable import Posterr

class AppDataSourceStub: AppDataSourceProtocol {
    
    var requestShouldFail = false
    
    func addNewPost(with message: String, for user: User, completion: RequestCompletion<Post>?) {
        guard requestShouldFail else {
            completion?(.success(.dummy()))
            return
        }
        
        completion?(.failure(.saveError))
    }

    func addRepost(of post: Post, for user: User, completion: RequestCompletion<Post>?) {
        guard requestShouldFail else {
            completion?(.success(.repostDummy()))
            return
        }
        
        completion?(.failure(.saveError))
    }

    func addQuotePost(for post: Post, with message: String, by user: User, completion: RequestCompletion<Post>?) {
        guard requestShouldFail else {
            completion?(.success(.quotePostDummy()))
            return
        }
        
        completion?(.failure(.saveError))
    }

    func getPosts(from user: User?, with limit: Int, and offset: Int, completion: RequestCompletion<[Post]>?) {
        guard requestShouldFail else {
            completion?(.success([.dummy(), .repostDummy(), .quotePostDummy()]))
            return
        }
        
        completion?(.failure(.fetchError))
    }

    func getPostCount(of user: User, for date: Date, completion: RequestCompletion<Int>?) {
        guard requestShouldFail else {
            completion?(.success(4))
            return
        }
        
        completion?(.failure(.fetchError))
    }

    func addNewUser(for username: String, completion: RequestCompletion<User>?) {
        guard requestShouldFail else {
            completion?(.success(.dummy()))
            return
        }
        
        completion?(.failure(.saveError))
    }

    func getUsers(completion: RequestCompletion<[User]>?) {
        guard requestShouldFail else {
            completion?(.success([.dummy()]))
            return
        }
        
        completion?(.failure(.fetchError))
    }

    func getUser(with username: String, completion: RequestCompletion<User>?) {
        guard requestShouldFail else {
            completion?(.success(.dummy()))
            return
        }
        
        completion?(.failure(.fetchError))
    }
    
}
