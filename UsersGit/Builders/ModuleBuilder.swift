//
//  ModuleBuilder.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 05.07.2022.
//

import Foundation
import UIKit

protocol Builder {
    
    static func createUserListModule() -> UIViewController
    static func createUserDetailModule(with username: String) -> UIViewController
    static func createEmojisModule() -> UIViewController
}

class ModuleBuilder: Builder {
    
    static func createUserListModule() -> UIViewController {
        let view = UserListViewController()
        let networkService = NetworkService()
        let presenter = UserListPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
    
    static func createUserDetailModule(with username: String) -> UIViewController {
        let view = UserDetailViewController()
        let networkService = NetworkService()
        let presenter = UserDetailPresenter(view: view, networkService: networkService, username: username)
        view.presenter = presenter
        
        return view
    }
    
    static func createEmojisModule() -> UIViewController {
        let view = EmojisViewController()
        let networkService = NetworkService()
        let presenter = EmojisPresenter(view: view, networkService: networkService)
        view.presenter = presenter
        
        return view
    }
}
