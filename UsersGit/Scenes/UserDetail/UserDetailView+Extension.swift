//
//  UserDetailView+Extension.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 06.07.2022.
//

import Foundation
import UIKit

extension UserDetailView {
    
    func makeAvatarImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        return imageView
    }
    
    func makeTitleLabel() -> UILabel {
        let label = makeLabel(size: 24)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.topAnchor.constraint(equalTo: safeTopAnchor, constant: 20)
        ])
        return label
    }
    
    func makeNameLabel() -> UILabel {
        let label = makeLabel(size: 20)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: safeLeftAnchor, constant: 40),
            label.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 20),
        ])
        return label
    }
    
    func makeEmailLabel() -> UILabel {
        let label = makeLabel(size: 20)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10)
        ])
        return label
    }
    
    func makeOrganizationLabel() -> UILabel {
        let label = makeLabel(size: 20)
        label.numberOfLines = 0
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            label.rightAnchor.constraint(equalTo: safeRightAnchor, constant: -40)
        ])
        return label
    }
    
    func makeFollowingLabel() -> UILabel {
        let label = makeLabel(size: 20)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: organizationLabel.bottomAnchor, constant: 10)
        ])
        return label
    }
    
    func makeFollowersLabel() -> UILabel {
        let label = makeLabel(size: 20)
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: followingLabel.bottomAnchor, constant: 10)
        ])
        return label
    }
    
    func makeDateLabel() -> UILabel {
        let label = makeLabel(size: 20)
        label.numberOfLines = 0
        addSubview(label)
        NSLayoutConstraint.activate([
            label.leftAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 0),
            label.topAnchor.constraint(equalTo: followersLabel.bottomAnchor, constant: 10),
            label.rightAnchor.constraint(equalTo: safeRightAnchor, constant: -40)
        ])
        return label
    }
    
    fileprivate func makeLabel(size: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: size)
        addSubview(label)
        return label
    }
    
}
