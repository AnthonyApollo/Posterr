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
    
    @objc func filterBy(user: User?, with key: String) {
        guard let user = user else { return }

        self.predicate = NSPredicate(format: "\(key) = %@", user)
    }
    
}