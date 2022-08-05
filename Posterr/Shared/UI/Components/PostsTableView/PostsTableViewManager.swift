//
//  PostsTableViewManager.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit

class PostsTableViewManager: NSObject {
    
    var posts: [Post]?
    
    init(posts: [Post]? = nil) {
        self.posts = posts
    }
    
}

extension PostsTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell,
              let post = posts?[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.setup(with: post)
        
        return cell
    }
    
}


