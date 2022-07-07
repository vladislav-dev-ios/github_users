//
//  UserDetailView.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 06.07.2022.
//

import Foundation
import UIKit

class UserDetailView: UIView {
    
    // MARK: Properties
    lazy var avatarImageView = makeAvatarImageView()
    
    lazy var titleLabel = makeTitleLabel()
    lazy var nameLabel = makeNameLabel()
    lazy var emailLabel = makeEmailLabel()
    lazy var organizationLabel = makeOrganizationLabel()
    lazy var followingLabel = makeFollowingLabel()
    lazy var followersLabel = makeFollowersLabel()
    lazy var dateLabel = makeDateLabel()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9802961946, green: 0.9804602265, blue: 1, alpha: 1)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public methods
    func configure(user: DetailUser) {
        
        titleLabel.text = user.login.uppercased()
        
        if let name = user.name {
            nameLabel.text = "Name: \(name)"
        } else {
            nameLabel.text = "Name not specified"
        }
        
        if let email = user.email {
            emailLabel.text = "Email: \(email)"
        } else {
            emailLabel.text = "Email not specified"
        }
        
        if let company = user.company {
            organizationLabel.text = "Orgranization: \(company)"
        } else {
            organizationLabel.text = "Orgranization not specified"
        }
        
        followingLabel.text = "Following: \(user.following)"
        followersLabel.text = "Followers: \(user.followers)"
        
        if let date = user.created_at {
            dateLabel.text = "Date of create: \(date)"
        }
        
        guard let url = URL(string: user.avatar_url) else {
            return
        }
        
        ImageLoader.fetchImage(url: url) { image in
            self.avatarImageView.image = image
        }
    }
    
}


