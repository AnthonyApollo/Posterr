//
//  UserProfileInteractor.swift
//  Posterr
//
//  Created by Anthony Apollo on 09/08/22.
//

final class UserProfileInteractor: UserProfileInteractorProtocol {
    
    private let appDataSource: AppDataSourceProtocol
    weak var output: UserProfileInteractorOutputProtocol?
    
    init(appDataSource: AppDataSourceProtocol = DataManager.shared) {
        self.appDataSource = appDataSource
    }
    
    func getUser() {
        appDataSource.getUser(with: "regularJohn22") { [weak self] result in
            switch result {
            case .success(let user):
                self?.output?.getUserSucceeded(with: user)
            case .failure(let error):
                self?.output?.operationFailed(with: error)
            }
        }
    }
    
}
