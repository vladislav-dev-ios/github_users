//
//  EmojisPresenter.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 07.07.2022.
//

import Foundation

protocol EmojisViewProtocol: AnyObject {
    func succes()
    func failure(error: Error)
}

protocol EmojisPresenterProtocol: AnyObject {
    init(view: EmojisViewProtocol, networkService: NetworkService)
    func fetchEmojis()
    func returnEmojisCount() -> Int
    func getUsedEmoji(at row: Int) -> String
    
}

class EmojisPresenter: EmojisPresenterProtocol {
    
    // MARK: - Properties
    private weak var view: EmojisViewProtocol?
    private let networkService: NetworkService!
    
    var emojisArray: [String] = []
    
    // MARK: - Init
    required init(view: EmojisViewProtocol, networkService: NetworkService) {
        self.view = view
        self.networkService = networkService
        
        fetchEmojis()
    }
    
    // MARK: - Public methods
    func fetchEmojis() {
        
        networkService.fetchEmojis { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let emojis):
                
                if let emojis = emojis {
                    for value in emojis.values {
                        self.emojisArray.append(value)
                    }
                }
                
                DispatchQueue.main.async {
                    self.view?.succes()
                }
            case .failure(let error):
                self.view?.failure(error: error)
            }
        }
    }
    
    func returnEmojisCount() -> Int {
        return emojisArray.count
    }
    
    func getUsedEmoji(at row: Int) -> String {
        return emojisArray[row]
    }
    
}
