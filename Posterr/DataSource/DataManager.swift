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
        guard let userDTO = getUserDTO(with: user.username) else {
            completion?(.failure(.fetchError))
            return
        }
        
        let entity = PostDTO(context: persistentContainer.viewContext)
        entity.id = UUID()
        entity.message = message
        entity.author = userDTO
        entity.date = .init()
        userDTO.posts += 1
        
        do {
            try saveContext()
            
            guard let domainPost = Post(from: entity) else {
                completion?(.failure(.invalidData))
                return
            }
            
            completion?(.success(domainPost))
        } catch {
            completion?(.failure(.saveError))
        }
    }
    
    func addRepost(of post: Post, for user: User, completion: RequestCompletion<Post>?) {
        guard let userDTO = getUserDTO(with: user.username),
              let postDTO = getPostDTO(with: post.id) else {
            completion?(.failure(.fetchError))
            return
        }
        
        let entity = PostDTO(context: persistentContainer.viewContext)
        entity.id = UUID()
        entity.author = userDTO
        entity.originalPost = postDTO
        entity.date = .init()
        userDTO.reposts += 1
        
        do {
            try saveContext()
            
            guard let domainPost = Post(from: entity) else {
                completion?(.failure(.invalidData))
                return
            }
            
            completion?(.success(domainPost))
        } catch {
            completion?(.failure(.saveError))
        }
    }
    
    func addQuotePost(for post: Post, with message: String, by user: User, completion: RequestCompletion<Post>?) {
        guard let userDTO = getUserDTO(with: user.username),
              let postDTO = getPostDTO(with: post.id) else {
            completion?(.failure(.fetchError))
            return
        }
        
        let entity = PostDTO(context: persistentContainer.viewContext)
        entity.id = UUID()
        entity.author = userDTO
        entity.message = message
        entity.quotePost = postDTO
        entity.date = .init()
        userDTO.quotePosts += 1
        
        do {
            try saveContext()
            
            guard let domainPost = Post(from: entity) else {
                completion?(.failure(.invalidData))
                return
            }
            
            completion?(.success(domainPost))
        } catch {
            completion?(.failure(.saveError))
        }
    }
    
    func getPosts(from user: User?, with limit: Int, and offset: Int, completion: RequestCompletion<[Post]>?) {
        let userDTO = getUserDTO(with: user?.username)
        
        let request: NSFetchRequest<PostDTO> = PostDTO.fetchRequest()
        request.sortBy(key: "date", ascending: false)
        request.filterPostsBy(user: userDTO)
        request.fetchLimit = limit
        request.fetchOffset = offset
        
        var fetchedPosts: [PostDTO] = []
        
        do {
            fetchedPosts = try persistentContainer.viewContext.fetch(request)
            let domainPosts = fetchedPosts.compactMap { Post(from: $0) }
            
            completion?(.success(domainPosts))
        } catch {
            completion?(.failure(.fetchError))
        }
    }
    
    func getPostCount(of user: User, for date: Date, completion: RequestCompletion<Int>?) {
        let userDTO = getUserDTO(with: user.username)
        
        let request: NSFetchRequest<PostDTO> = PostDTO.fetchRequest()
        request.filterPostsBy(user: userDTO)
        
        var fetchedPosts: [PostDTO] = []
        
        do {
            fetchedPosts = try persistentContainer.viewContext.fetch(request)
            let count = fetchedPosts.filter { $0.date?.day == date.day }.count
            completion?(.success(count))
        } catch {
            completion?(.failure(.fetchError))
        }
    }
    
    private func getPostDTO(with id: UUID) -> PostDTO? {
        let request: NSFetchRequest<PostDTO> = PostDTO.fetchRequest()
        request.filterPostsBy(id: id)
        
        var fetchedPosts: [PostDTO] = []
        
        do {
            fetchedPosts = try persistentContainer.viewContext.fetch(request)
            return fetchedPosts.first
        } catch {
            return nil
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
        guard let userDTO = getUserDTO(with: username),
              let domainUser = User(from: userDTO) else {
            completion?(.failure(.fetchError))
            return
        }
        
        completion?(.success(domainUser))
    }
    
    private func getUserDTO(with username: String?) -> UserDTO? {
        guard let username = username else {
            return nil
        }
        
        let request: NSFetchRequest<UserDTO> = UserDTO.fetchRequest()
        request.filterUsersBy(username: username)
        
        var fetchedUsers: [UserDTO] = []
        
        do {
            fetchedUsers = try persistentContainer.viewContext.fetch(request)
            return fetchedUsers.first
        } catch {
            return nil
        }
    }
    
}
