//
//  DataSourceProtocols.swift
//  Posterr
//
//  Created by Anthony Apollo on 07/08/22.
//

import Foundation

protocol AppDataSourceProtocol: AnyObject {
    
    func addNewPost(with message: String, for user: User, completion: RequestCompletion<Post>?)
    func addRepost(of post: Post, for user: User, completion: RequestCompletion<Post>?)
    func addQuotePost(for post: Post, with message: String, by user: User, completion: RequestCompletion<Post>?)
    func getPosts(from user: User?, completion: RequestCompletion<[Post]>?)
    func addNewUser(for username: String, completion: RequestCompletion<User>?)
    func getUsers(completion: RequestCompletion<[User]>?)
    
}

typealias RequestCompletion<T> = (RequestResult<T>) -> Void

enum RequestResult<T> {
    
    case success(T)
    case failure(RequestError)
    
}

enum RequestError: LocalizedError, Identifiable {
    
    var id: String { localizedDescription }
  
    case fetchError
    case invalidData
    case saveError
  
    var errorDescription: String {
        switch self {
        case .fetchError:
            return "An error occurred while retrieving server information."
        case .invalidData:
            return "Invalid data format."
        case .saveError:
            return "An error occurred while saving data."
        }
    }
    
}
