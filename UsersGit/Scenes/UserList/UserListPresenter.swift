//
//  UserListPresenter.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 05.07.2022.
//

import Foundation
import UIKit

protocol UserListViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
    func presentModule(vc : UIViewController)
}

protocol UserListPresenterProtocol: AnyObject {
    
    init(view: UserListViewProtocol, networkService: NetworkService)
    func fetchUsers()
    func returnUsersCount() -> Int
    func getUsedUser(at tow: Int) -> UserGit?
    func getSelectedUsername(at row: Int) -> String?
    func openDetailModule(with username: String)
    func willDisplayRepository(at row: Int)
    func prepareRefresh()
    
    var users: [UserGit]? { get set }
}

class UserListPresenter: UserListPresenterProtocol {
    
    // MARK: - Properties
    private weak var view: UserListViewProtocol?
    private let networkService: NetworkService!
    
    var users: [UserGit]?
    var paginationUsers: [UserGit] = []
    
    //MARK: - Pagination vars
    var usersPerPages = 10
    var limit: Int = 10
    
    // MARK: - Init
    required init(view: UserListViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
        
        fetchUsers()
    }
    
    // MARK: - Public methods
    func prepareRefresh() {
        limit = 10
        usersPerPages = 10
    }
    
    func fetchUsers() {
        
        networkService.fetchUsers { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let users):
                    self.users = users
                    self.limit = self.users?.count ?? 0
                    
                    self.paginationUsers = []
                    for i in 0..<10 {
                        if let user = users?[i] {
                            self.paginationUsers.append(user)
                        }
                        
                        
                        self.view?.succes()
                    }
                    
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
    
    func returnUsersCount() -> Int {
        return paginationUsers.count
    }
    
    func getUsedUser(at row: Int) -> UserGit? {
        return paginationUsers[row]
    }
    
    func getSelectedUsername(at row: Int) -> String? {
        return paginationUsers[row].login
    }
    
    func openDetailModule(with username: String) {
        let userDetailModule = ModuleBuilder.createUserDetailModule(with: username)
        
        view?.presentModule(vc: userDetailModule)
    }
    
    func willDisplayRepository(at row: Int) {
        if row == paginationUsers.count - 1 {
            addNewUsers()
        }
    }
    
    
}

//MARK: - Private funcs
extension UserListPresenter {
    
    private func addNewUsers() {
        
        guard let users = users else { return }
        
        if usersPerPages >= limit {
            return
        }
        else if usersPerPages >= limit - 10 {
            for i in usersPerPages..<limit {
                paginationUsers.append(users[i])
            }
            usersPerPages += 10
        }
        else {
            for i in usersPerPages..<usersPerPages + 10 {
                paginationUsers.append(users[i])
            }
            usersPerPages += 10
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.view?.succes()
        }
    }
}
