//
//  FeedPresenter.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

final class FeedPresenter: FeedPresenterProtocol {
    
    private let postMaximumCharacters = 777
    
    weak var view: FeedViewProtocol?
    private let interactor: FeedInteractorProtocol
    let tableViewManager = PostsTableViewManager()
    
    init(interactor: FeedInteractorProtocol) {
        self.interactor = interactor
    }
    
    func setup() {
        interactor.getPosts()
    }
    
    func updateLabelIfNeeded(_ postCreationView: PostCreationView, for textLength: Int) {
        guard shouldUpdateTextView(for: textLength) else { return }
        
        let text = textLength == 0 ? nil : String(postMaximumCharacters - textLength)
        postCreationView.updateRemainingCharacters(with: text)
    }
    
    func shouldUpdateTextView(for length: Int) -> Bool {
        return length <= postMaximumCharacters
    }
    
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    
    func getPostsSuccess(result: [Post]) {
        tableViewManager.posts = result
    }
    
}
