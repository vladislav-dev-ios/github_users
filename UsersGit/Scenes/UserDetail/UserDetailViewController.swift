//
//  UserDetailViewController.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 06.07.2022.
//

import Foundation
import UIKit

class UserDetailViewController: UIViewController {
    
    // MARK: Properties
    private lazy var customView = UserDetailView()
    
    var presenter: UserDetailPresenterProtocol?
    
    // MARK: - Life Cycle
    override func loadView() {
        super.loadView()
        
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}

// MARK: - UserDetailViewProtocol Protocol
extension UserDetailViewController: UserDetailViewProtocol {
    
    func succes(user: DetailUser) {
        customView.configure(user: user)
        title = user.login
    }
    
    func failure(error: Error) {
        print(error)
    }
    
}
