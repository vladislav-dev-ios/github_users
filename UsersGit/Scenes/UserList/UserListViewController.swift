//
//  UserListViewController.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 05.07.2022.
//

import Foundation
import UIKit

class UserListViewController: UIViewController {
    
    // MARK: -  Properties
    private let userTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UserTableCiewCell.self, forCellReuseIdentifier: UserTableCiewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let refreshControl = UIRefreshControl()
    
    var presenter: UserListPresenterProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9802961946, green: 0.9804602265, blue: 1, alpha: 1)
        title = "Github Users"
        
        setupTableView()
        setupRefreshControl()

    }
    
    // MARK: - Priavate Methods
    private func setupRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        userTableView.addSubview(refreshControl)
    }
    
    private func setupTableView() {
        userTableView.delegate = self
        userTableView.dataSource = self
        view.addSubview(userTableView)
        NSLayoutConstraint.activate([
            userTableView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            userTableView.leftAnchor.constraint(equalTo: view.safeLeftAnchor),
            userTableView.rightAnchor.constraint(equalTo: view.safeRightAnchor),
            userTableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
        ])
    }
    
    @objc private func refresh(_ sender: AnyObject) {
        presenter?.prepareRefresh()
        presenter?.fetchUsers()
    }
}

// MARK: - UserListViewProtocol Protocol
extension UserListViewController: UserListViewProtocol {
    
    func succes() {
        
        userTableView.reloadData()
        if refreshControl.isRefreshing {
            refreshControl.endRefreshing()
        }
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    func presentModule(vc : UIViewController) {
        present(vc, animated: true)
    }
    
}

//MARK: - UITableViewDataSource, UITableViewDelegate
extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.returnUsersCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UserTableCiewCell.identifier, for: indexPath) as! UserTableCiewCell
        
        let user = presenter?.getUsedUser(at: indexPath.row)
        
        guard let user = user else {
            return cell
        }
        
        cell.configure(user: user)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return userTableView.bounds.height / 7.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let username = presenter?.getSelectedUsername(at: indexPath.row) else { return }
        
        presenter?.openDetailModule(with: username)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        presenter?.willDisplayRepository(at: indexPath.row)
    }
    
}
