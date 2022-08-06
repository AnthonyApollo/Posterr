//
//  ApplicationInteractor.swift
//  Posterr
//
//  Created by Anthony Apollo on 05/08/22.
//

final class ApplicationInteractor: ApplicationInteractorProtocol {
    
    private let appDataSource: AppDataSourceProtocol
    weak var output: ApplicationInteractorOutputProtocol?
    
    init(appDataSource: AppDataSourceProtocol = DataManager.shared) {
        self.appDataSource = appDataSource
        
        injectMockedData()
    }
    
    func getCurrentUser() {
        let users = appDataSource.getUsers()
        
        guard let result = users.first else { return }
        
        output?.getCurrentUserSucceeded(with: result)
    }
    
}

extension ApplicationInteractor {
    
    func injectMockedData() {
        let users = appDataSource.getUsers()
        
        guard users.isEmpty else { return }
        
        let user1 = appDataSource.addNewUser(for: "user2022")
        appDataSource.addNewPost(with: "Trying my social network ;)", for: user1!)
        
        let user2 = appDataSource.addNewUser(for: "elonMusk")
        appDataSource.addNewPost(with: "I wanna buy Posterr", for: user2!)
        
        let user3 = appDataSource.addNewUser(for: "bruceLee")
        appDataSource.addNewPost(with: "Be water my friend", for: user3!)
        
        let user4 = appDataSource.addNewUser(for: "corleoneDon")
        appDataSource.addNewPost(with: "I will make him an offer...", for: user4!)
    }
    
}
