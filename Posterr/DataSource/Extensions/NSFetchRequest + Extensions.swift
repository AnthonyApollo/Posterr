//
//  NSFetchRequest + Extensions.swift
//  Posterr
//
//  Created by Anthony Apollo on 07/08/22.
//

import Foundation
import CoreData

extension NSFetchRequest {
    
    @objc func sortBy(key: String, ascending: Bool) {
        self.sortDescriptors = [NSSortDescriptor(key: key, ascending: ascending)]
    }
    
    @objc func filterPostsBy(user: User?) {
        guard let user = user else { return }

        self.predicate = NSPredicate(format: "author = %@", user)
    }
    
    @objc func filterUsersBy(username: String) {
        self.predicate = NSPredicate(format: "username = %@", username)
    }
    
}
