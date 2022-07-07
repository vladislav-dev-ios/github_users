//
//  UserDetailPresenter.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 06.07.2022.
//

import Foundation

protocol UserDetailViewProtocol: AnyObject {
    func succes(user: DetailUser)
    func failure(error: Error)
}

protocol UserDetailPresenterProtocol: AnyObject {
    init(view: UserDetailViewProtocol, networkService: NetworkService, username: String)
    func fetchUser()
    
    var user: DetailUser? { get set }
}

class UserDetailPresenter: UserDetailPresenterProtocol {
    
    // MARK: - Properties
    private weak var view: UserDetailViewProtocol?
    private let networkService: NetworkService!
    
    var user: DetailUser?
    private let username: String!
    
    // MARK: - Init
    required init(view: UserDetailViewProtocol, networkService: NetworkService, username: String) {
        self.view = view
        self.networkService = networkService
        self.username = username
        
        fetchUser()
    }
    
    // MARK: - Public methods
    func fetchUser() {
        
        networkService.fetchUser(with: username) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                
                switch result {
                case .success(let user):
                    self.user = user
                    self.view?.succes(user: user!)
                case .failure(let error):
                    self.view?.failure(error: error)
                }
            }
        }
    }
}
