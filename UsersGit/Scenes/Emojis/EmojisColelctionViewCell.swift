//
//  EmojisColelctionViewCell.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 07.07.2022.
//

import Foundation
import UIKit

class EmojisCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let identifier = "EmojisCollectionViewCell"
    
    private let imageView = UIImageView()
    private let activityIndicatorView = UIActivityIndicatorView()
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: .zero)
      
        addActivityIndicatorView()
        addImageView()
        
        startLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Priavate Methods
    private func addActivityIndicatorView() {
        activityIndicatorView.layer.zPosition = 2
        activityIndicatorView.tintColor = .black
        activityIndicatorView.color = .black
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    private func startLoading() {
        activityIndicatorView.startAnimating()
    }
    
    private func stopLoading() {
        activityIndicatorView.stopAnimating()
    }
    
    private func addImageView() {
        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.zPosition = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor)
        ])
    }
    
}

// MARK: - Configure Cell
extension EmojisCollectionViewCell {
    
    func configure(url: String) {
        
        guard let url = URL(string: url) else {
            return
        }
        
        if imageView.image != nil {
            imageView.image = nil
            startLoading()
        }

        ImageLoader.fetchImage(url: url) { image in
            self.imageView.image = image
            self.stopLoading()
        }

    }
}

