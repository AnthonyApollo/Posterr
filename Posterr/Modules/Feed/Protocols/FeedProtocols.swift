//
//  FeedProtocols.swift
//  Posterr
//
//  Created by Anthony Apollo on 03/08/22.
//

protocol FeedViewProtocol: AnyObject {
    
    func reloadFeed()
    
}

protocol FeedPresenterProtocol: AnyObject {
    
    var tableViewManager: PostsTableViewManager { get }
    var view: FeedViewProtocol? { get set }
    
    func setup()
    
}

protocol FeedInteractorProtocol: AnyObject {
    
    var output: FeedInteractorOutputProtocol? { get set }
    
    func getPosts()
    
}

protocol FeedInteractorOutputProtocol: AnyObject {
    
    func getPostsSuccess(result: [Post])
    
}
