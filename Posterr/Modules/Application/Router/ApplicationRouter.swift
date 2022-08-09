//
//  ApplicationRouter.swift
//  Posterr
//
//  Created by Anthony Apollo on 08/08/22.
//

struct ApplicationRouter {
    
    static func createModule() -> ApplicationTabBarController {
        let interactor = ApplicationInteractor()
        let presenter = ApplicationPresenter(interactor: interactor)
        
        return ApplicationTabBarController(presenter: presenter)
    }
    
}
