//
//  DataManager.swift
//  Posterr
//
//  Created by Anthony Apollo on 05/08/22.
//

import Foundation
import CoreData

protocol AppDataSourceProtocol: AnyObject {
    
    func addNewPost(with: String, for: User)
    func getPosts() -> [Post]
    func addNewUser(for: String) -> User?
    func getUsers() -> [User]
    
}

final class DataManager: AppDataSourceProtocol {
    
    static let shared = DataManager()
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Posterr")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

// MARK: - Post requests
extension DataManager {
    
    func addNewPost(with message: String, for user: User) {
        let entity = Post(context: persistentContainer.viewContext)
        entity.message = message
        entity.author = user
        entity.date = .init()
        
        saveContext()
    }
    
    func getPosts() -> [Post] {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        var fetchedPosts: [Post] = []
        
        do {
            fetchedPosts = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Erro fetching posts")
        }
        
        return fetchedPosts
    }
    
}

// MARK: - User requests
extension DataManager {

    func addNewUser(for username: String) -> User? {
        guard username.isValidUsername else { return nil }
        
        let entity = User(context: persistentContainer.viewContext)
        entity.username = username
        entity.joinedDate = .init()
        
        saveContext()
        
        return entity
    }
    
    func getUsers() -> [User] {
        let request: NSFetchRequest<User> = User.fetchRequest()
        
        request.sortDescriptors = [NSSortDescriptor(key: "joinedDate", ascending: true)]
        
        var fetchedUsers: [User] = []
        
        do {
            fetchedUsers = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Erro fetching posts")
        }
        
        return fetchedUsers
    }
    
}
