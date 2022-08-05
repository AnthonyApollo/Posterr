//
//  FeedPresenter.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

import UIKit

final class FeedPresenter: NSObject, FeedPresenterProtocol {
    
    private let postMaximumCharacters = 777
    
    weak var view: FeedViewProtocol?
    private let interactor: FeedInteractorProtocol
    private var posts: [Post]?
    
    init(interactor: FeedInteractorProtocol) {
        self.interactor = interactor
    }
    
    func setup() {
        interactor.getPosts()
    }
    
    func updateLabelIfNeeded(_ postCreationView: PostCreationView, for textLength: Int) {
        guard shouldUpdateTextView(for: textLength) else { return }
        
        let text = textLength == 0 ? nil : String(postMaximumCharacters - textLength)
        
        DispatchQueue.main.async {
            postCreationView.updateRemainingCharacters(with: text)
        }
    }
    
    func shouldUpdateTextView(for length: Int) -> Bool {
        return length <= postMaximumCharacters
    }
    
    func post(_ message: String) {
        interactor.addNewPost(for: message)
    }
    
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    
    func getPostsSucceeded(with result: [Post]) {
        posts = result
        view?.reloadFeed()
    }
    
    func addNewPostSucceeded() {
        interactor.getPosts()
    }
    
}

extension FeedPresenter: UITableViewDataSource {
    
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
