//
//  FeedRouterStub.swift
//  PosterrTests
//
//  Created by Anthony Apollo on 10/08/22.
//

@testable import Posterr

class FeedRouterStub: FeedRouterProtocol {
    
    func createModule(with user: User, toUserProfile isOnUserProfile: Bool) -> FeedViewProtocol {
        let interactor = FeedInteractorStub()
        let presenter = FeedPresenter(interactor: interactor, currentUser: user, isOnUserProfile: true)
        let viewController = FeedViewController(presenter: presenter)
        
        interactor.output = presenter
        presenter.view = viewController
        
        return viewController
    }
    
    func createModule(with user: User, and delegate: FeedViewControllerDelegate?) -> FeedViewProtocol {
        return createModule(with: user, toUserProfile: false)
    }
    
}
