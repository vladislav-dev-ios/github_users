//
//  MainTabBarViewController.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 05.07.2022.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
        
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
          
        setUpTabBarController()
        
    }
    
    //MARK: - Private funcs
    private func setUpTabBarController() {
        
        let usersModule = ModuleBuilder.createUserListModule()
        let usersNavController = generateNavigationController(vc: usersModule, title: "Users", image: UIImage(named: "user")!)
        
        let emojisModule = ModuleBuilder.createEmojisModule()
        let emojisNavController = generateNavigationController(vc: emojisModule, title: "Emojis", image: UIImage(named: "emoji")!)
        
        viewControllers = [usersNavController, emojisNavController]
        
    }
    
    private func generateNavigationController(vc: UIViewController, title: String, image: UIImage) -> UINavigationController{
        let navController = UINavigationController(rootViewController: vc)
        navController.title = title
        navController.tabBarItem.image = image
        
        return navController
    }
    
    
}

