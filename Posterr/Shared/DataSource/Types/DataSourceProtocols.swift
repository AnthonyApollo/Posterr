//
//  DataSourceProtocols.swift
//  Posterr
//
//  Created by Anthony Apollo on 07/08/22.
//

import Foundation

typealias RequestCompletion<T> = (RequestResult<T>) -> Void

protocol AppDataSourceProtocol: AnyObject {
    
    func addNewPost(with message: String, for user: User, completion: RequestCompletion<Post>?)
    func addRepost(of post: Post, for user: User, completion: RequestCompletion<Post>?)
    func addQuotePost(for post: Post, with message: String, by user: User, completion: RequestCompletion<Post>?)
    func getPosts(from user: User?, completion: RequestCompletion<[Post]>?)
    func addNewUser(for username: String, completion: RequestCompletion<User>?)
    func getUsers(completion: RequestCompletion<[User]>?)
    
}
