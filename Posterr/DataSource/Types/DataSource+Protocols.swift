//
//  DataSourceProtocols.swift
//  Posterr
//
//  Created by Anthony Apollo on 07/08/22.
//

import Foundation

typealias RequestCompletion<T> = (RequestResult<T>) -> Void

protocol AppDataSourceProtocol: AnyObject {
    
    func addNewPost(with message: String, for user: DomainUser, completion: RequestCompletion<Post>?)
    func addRepost(of post: Post, for user: DomainUser, completion: RequestCompletion<Post>?)
    func addQuotePost(for post: Post, with message: String, by user: DomainUser, completion: RequestCompletion<Post>?)
    func getPosts(from user: DomainUser?, with limit: Int, and offset: Int, completion: RequestCompletion<[Post]>?)
    func addNewUser(for username: String, completion: RequestCompletion<DomainUser>?)
    func getUsers(completion: RequestCompletion<[DomainUser]>?)
    func getUser(with username: String, completion: RequestCompletion<DomainUser>?)
    
}
