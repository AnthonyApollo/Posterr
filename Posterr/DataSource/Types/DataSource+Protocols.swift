//
//  DataSourceProtocols.swift
//  Posterr
//
//  Created by Anthony Apollo on 07/08/22.
//

import Foundation

typealias RequestCompletion<T> = (RequestResult<T>) -> Void

protocol AppDataSourceProtocol: AnyObject {
    
    func addNewPost(with message: String, for user: User, completion: RequestCompletion<DomainPost>?)
    func addRepost(of post: DomainPost, for user: User, completion: RequestCompletion<DomainPost>?)
    func addQuotePost(for post: DomainPost, with message: String, by user: User, completion: RequestCompletion<DomainPost>?)
    func getPosts(from user: User?, with limit: Int, and offset: Int, completion: RequestCompletion<[DomainPost]>?)
    func addNewUser(for username: String, completion: RequestCompletion<User>?)
    func getUsers(completion: RequestCompletion<[User]>?)
    func getUser(with username: String, completion: RequestCompletion<User>?)
    
}
