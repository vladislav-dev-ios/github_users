//
//  NetworkService.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 05.07.2022.
//

import Foundation

typealias EmojiResult = [String:String]

protocol NetworkServiceProtocol {
    func fetchUsers(completion: @escaping (Result<[UserGit]?, Error>) -> Void)
    func fetchUser(with username: String, completion: @escaping (Result<DetailUser?, Error>) -> Void)
    func fetchEmojis(completion: @escaping (Result<EmojiResult?, Error>) -> Void)
}

class NetworkService: NetworkServiceProtocol {
    
    private let usersUrl = "https://api.github.com/users"
    private let emojuUrl = "https://api.github.com/emojis"

    func fetchUsers(completion: @escaping (Result<[UserGit]?, Error>) -> Void) {

        guard let url = URL(string: usersUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                let obj = try JSONDecoder().decode([UserGit].self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
  
    func fetchUser(with username: String, completion: @escaping (Result<DetailUser?, Error>) -> Void) {
        
        let userUrl = usersUrl + "/\(username)"
        
        guard let url = URL(string: userUrl) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                let obj = try JSONDecoder().decode(DetailUser.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func fetchEmojis(completion: @escaping (Result<EmojiResult?, Error>) -> Void) {
        
        guard let url = URL(string: emojuUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            do {
                let obj = try JSONDecoder().decode(EmojiResult.self, from: data!)
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
}
