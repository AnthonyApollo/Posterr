//
//  DataManager.swift
//  Posterr
//
//  Created by Anthony Apollo on 05/08/22.
//

import Foundation
import CoreData

final class DataManager: AppDataSourceProtocol {
    
    static let shared = DataManager()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Posterr")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() throws {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            try context.save()
        }
    }
    
}

// MARK: - Post requests

extension DataManager {
    
    func addNewPost(with message: String, for user: User, completion: RequestCompletion<Post>?) {
        let entity = Post(context: persistentContainer.viewContext)
        entity.message = message
        entity.author = user.dto
        entity.date = .init()
        user.dto?.posts += 1
        
        do {
            try saveContext()
            completion?(.success(entity))
        } catch {
            completion?(.failure(.saveError))
        }
    }
    
    func addRepost(of post: Post, for user: User, completion: RequestCompletion<Post>?) {
        let entity = Post(context: persistentContainer.viewContext)
        entity.author = user.dto
        entity.originalPost = post
        entity.date = .init()
        user.dto?.reposts += 1
        
        do {
            try saveContext()
            completion?(.success(entity))
        } catch {
            completion?(.failure(.saveError))
        }
    }
    
    func addQuotePost(for post: Post, with message: String, by user: User, completion: RequestCompletion<Post>?) {
        let entity = Post(context: persistentContainer.viewContext)
        entity.author = user.dto
        entity.message = message
        entity.quotePost = post
        entity.date = .init()
        user.dto?.quotePosts += 1
        
        do {
            try saveContext()
            completion?(.success(entity))
        } catch {
            completion?(.failure(.saveError))
        }
    }
    
    func getPosts(from user: User?, with limit: Int, and offset: Int, completion: RequestCompletion<[Post]>?) {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        request.sortBy(key: "date", ascending: false)
        request.filterPostsBy(user: user?.dto)
        request.fetchLimit = limit
        request.fetchOffset = offset
        
        var fetchedPosts: [Post] = []
        
        do {
            fetchedPosts = try persistentContainer.viewContext.fetch(request)
            completion?(.success(fetchedPosts))
        } catch {
            completion?(.failure(.fetchError))
        }
    }
    
}

// MARK: - User requests

extension DataManager {

    func addNewUser(for username: String, completion: RequestCompletion<User>?) {
        guard username.isValidUsername else {
            completion?(.failure(.invalidData))
            return
        }
        
        let entity = UserDTO(context: persistentContainer.viewContext)
        entity.username = username
        entity.joinedDate = .init()
        
        do {
            try saveContext()
            
            guard let domainUser = User(from: entity) else {
                completion?(.failure(.invalidData))
                return
            }
            
            completion?(.success(domainUser))
        } catch {
            completion?(.failure(.saveError))
        }
    }
    
    func getUsers(completion: RequestCompletion<[User]>?) {
        let request: NSFetchRequest<UserDTO> = UserDTO.fetchRequest()
        request.sortBy(key: "joinedDate", ascending: true)
        
        var fetchedUsers: [UserDTO] = []
        
        do {
            fetchedUsers = try persistentContainer.viewContext.fetch(request)
            let fetchedDomainUsers = fetchedUsers.compactMap { User(from: $0) }
            
            completion?(.success(fetchedDomainUsers))
        } catch {
            completion?(.failure(.fetchError))
        }
    }
    
    func getUser(with username: String, completion: RequestCompletion<User>?) {
        let request: NSFetchRequest<UserDTO> = UserDTO.fetchRequest()
        request.filterUsersBy(username: username)
        
        var fetchedUsers: [UserDTO] = []
        
        do {
            fetchedUsers = try persistentContainer.viewContext.fetch(request)
            
            guard let user = fetchedUsers.first,
            let domainUser = User(from: user) else {
                completion?(.failure(.fetchError))
                return
            }
            
            completion?(.success(domainUser))
        } catch {
            completion?(.failure(.fetchError))
        }
    }
    
}
