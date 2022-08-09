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
        appDataSource.getUser(with: "regularJohn22") { [weak self] result in
            switch result {
            case .success(let user):
                self?.output?.getCurrentUserSucceeded(with: user)
            case .failure(let error):
                self?.output?.operationFailed(with: error)
            }
        }
    }
    
}

extension ApplicationInteractor {
    
    func injectMockedData() {
        var users: [User] = []
        
        appDataSource.getUsers() { result in
            switch result {
            case .success(let returnedUsers):
                users = returnedUsers
            default:
                return
            }
        }
        
        guard users.isEmpty else { return }
        
        appDataSource.addNewUser(for: "regularJohn22") { [weak self] result in
            switch result {
            case .success(let user):
                self?.appDataSource.addNewPost(with: "Trying my social network ;)", for: user, completion: nil)
            default:
                return
            }
        }
        
        appDataSource.addNewUser(for: "elonMusk") { [weak self] result in
            switch result {
            case .success(let user):
                self?.appDataSource.addNewPost(with: "I wanna buy Posterr", for: user, completion: nil)
            default:
                return
            }
        }
        
        appDataSource.addNewUser(for: "bruceLee") { [weak self] result in
            switch result {
            case .success(let user):
                self?.appDataSource.addNewPost(with: "Be water my friend", for: user, completion: nil)
            default:
                return
            }
        }
        
        appDataSource.addNewUser(for: "corleoneDon") { [weak self] result in
            switch result {
            case .success(let user):
                self?.appDataSource.addNewPost(with: "I will make him an offer...", for: user, completion: nil)
            default:
                return
            }
        }
    }
    
}
