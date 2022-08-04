//
//  PostsTableViewManager.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit

class PostsTableViewManager: NSObject {
    
    var posts: [Post]
    
    init(posts: [Post]) {
        self.posts = posts
    }
    
}

extension PostsTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostTableViewCell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setup(with: posts[indexPath.row])
        
        return cell
    }
    
}

extension PostsTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Implementation
    }
    
}


