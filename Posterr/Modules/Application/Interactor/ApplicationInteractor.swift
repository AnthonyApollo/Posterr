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
    }
    
    func getCurrentUser() {
        var users = appDataSource.getUsers()
        
        if users.isEmpty {
            appDataSource.addNewUser(for: "defaultUser2022")
            users = appDataSource.getUsers()
        }
        
        guard let result = users.first else { return }
        
        output?.getCurrentUserSucceeded(with: result)
    }
    
}
