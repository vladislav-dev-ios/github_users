//
//  DetailUser.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 06.07.2022.
//

import Foundation

struct DetailUser: Decodable {
    
    let login: String
    let avatar_url: String
    let name: String?
    let email: String?
    let company: String?
    let followers: Int
    let following: Int
    let created_at: String?
}
