//
//  UserTableViewCell.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 05.07.2022.
//

import Foundation
import UIKit

class UserTableCiewCell: UITableViewCell {
    
    // MARK: Properties
    static let identifier = "UserTableCiewCell"
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let statusIndicatorView: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .gray)
        activity.tintColor = .black
        activity.color = .black
        activity.startAnimating()
        activity.translatesAutoresizingMaskIntoConstraints = false
        return activity
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22)
        return label
    }()
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .clear
        
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupConstraints() {
        contentView.addSubview(avatarImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(statusIndicatorView)
        NSLayoutConstraint.activate([
            avatarImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            avatarImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 5/6),
            
            titleLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 5),
            titleLabel.bottomAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            
            subTitleLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: 5),
            subTitleLabel.topAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            
            statusIndicatorView.centerXAnchor.constraint(equalTo: avatarImageView.centerXAnchor),
            statusIndicatorView.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
    
}

// MARK: - Configure Cell
extension UserTableCiewCell {
    
    public func configure(user: UserGit) {
        
        titleLabel.text = user.login
        subTitleLabel.text = "\(user.id)"
        
        statusIndicatorView.startAnimating()
        avatarImageView.image = nil
        
        guard let url = URL(string: user.avatar_url) else { return }
        
        ImageLoader.fetchImage(url: url) { image in
            if let image = image {
                self.statusIndicatorView.stopAnimating()
                self.avatarImageView.image = image
            }
        }
    }
}
