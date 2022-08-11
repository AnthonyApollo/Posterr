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
        appDataSource.getUser(with: "johnDoe22") { [weak self] result in
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
        
        appDataSource.addNewUser(for: "johnDoe22", completion: nil)
        
        appDataSource.addNewUser(for: "plantRobert") { [weak self] result in
            switch result {
            case .success(let user):
                self?.appDataSource.addNewPost(with: "And as we wind on down the road\nOur shadows taller than our soul\nThere walks a lady we all know\nWho shines white light and wants to show\nHow everything still turns to gold\nAnd if you listen very hard\nThe tune will come to you at last\nWhen all is one and one is all, that's what it is\nTo be a rock and not to roll, oh yeah\nAnd she's buying a stairway to heaven", for: user, completion: nil)
            default:
                return
            }
        }
        
        appDataSource.addNewUser(for: "bruceLee") { [weak self] result in
            switch result {
            case .success(let user):
                self?.appDataSource.addNewPost(with: "Be water my friend 🙏🏻", for: user, completion: nil)
            default:
                return
            }
        }
        
        appDataSource.addNewUser(for: "lordChurchill") { [weak self] result in
            switch result {
            case .success(let user):
                self?.appDataSource.addNewPost(with: "We shall go on to the end, we shall fight in France, we shall fight on the seas and oceans, we shall fight with growing confidence and growing strength in the air, we shall defend our Island, whatever the cost may be, we shall fight on the beaches, we shall fight on the landing grounds, we shall fight in the fields and in the streets, we shall fight in the hills; we shall never surrender, and even if, which I do not for a moment believe, this Island or a large part of it were subjugated and starving, then our Empire beyond the seas, armed and guarded by the British Fleet, would carry on the struggle, until, in God’s good time, the New World, with all its power and might, steps forth to the rescue and the liberation of the old.", for: user, completion: nil)
            default:
                return
            }
        }
        
        appDataSource.addNewUser(for: "corleoneDon") { [weak self] result in
            switch result {
            case .success(let user):
                self?.appDataSource.addNewPost(with: "I will make him an offer that he can't refuse.", for: user, completion: nil)
            default:
                return
            }
        }
        
        appDataSource.addNewUser(for: "johnFKennedy") { [weak self] result in
            switch result {
            case .success(let user):
                self?.appDataSource.addNewPost(with: "We choose to go to the Moon in this decade and do the other things, not because they are easy, but because they are hard, because that goal will serve to organize and measure the best of our energies and skills, because that challenge is one that we are willing to accept, one we are unwilling to postpone, and one which we intend to win, and the others, too.", for: user, completion: nil)
            default:
                return
            }
        }
        
        appDataSource.addNewUser(for: "kingMartin") { [weak self] result in
            switch result {
            case .success(let user):
                self?.appDataSource.addNewPost(with: "I have a dream that one day this nation will rise up and live out the true meaning of its creed: \"We hold these truths to be self-evident, that all men are created equal.\"", for: user, completion: nil)
            default:
                return
            }
        }
        
        appDataSource.addNewUser(for: "markZuckerberg") { [weak self] result in
            switch result {
            case .success(let user):
                self?.appDataSource.addNewPost(with: "This social network is amazing 😍", for: user, completion: nil)
            default:
                return
            }
        }
        
        appDataSource.addNewUser(for: "jobsSteve") { [weak self] result in
            switch result {
            case .success(let user):
                self?.appDataSource.addNewPost(with: "Stay hungry, stay foolish 🍎", for: user, completion: nil)
            default:
                return
            }
        }
    }
    
}
