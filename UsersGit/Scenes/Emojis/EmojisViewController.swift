//
//  EmojisViewController.swift
//  UsersGit
//
//  Created by Владислав Кузьмичёв on 07.07.2022.
//

import Foundation
import UIKit

class EmojisViewController: UIViewController {
    
    // MARK: - Properties
    private let emojisCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(EmojisCollectionViewCell.self,  forCellWithReuseIdentifier: EmojisCollectionViewCell.identifier)
        return cv
    }()
    
    var presenter: EmojisPresenterProtocol?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.9802961946, green: 0.9804602265, blue: 1, alpha: 1)
        title = "Emojis"
        
        setupCollectionView()
    }
    
    // MARK: - Priavate Methods
    private func setupCollectionView() {
        emojisCollectionView.delegate = self
        emojisCollectionView.dataSource = self
        view.addSubview(emojisCollectionView)
        NSLayoutConstraint.activate([
            emojisCollectionView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            emojisCollectionView.leftAnchor.constraint(equalTo: view.safeLeftAnchor, constant: 5),
            emojisCollectionView.rightAnchor.constraint(equalTo: view.safeRightAnchor, constant: -5),
            emojisCollectionView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
        ])
    }
}

// MARK: - EmojisViewProtocol Protocol
extension EmojisViewController: EmojisViewProtocol {
    
    func succes() {
        emojisCollectionView.reloadData()
    }
    
    func failure(error: Error) {
        print(error.localizedDescription)
    }
    
    
}

//MARK: - UICollectionViewDelegateFlowLayout, UICollectionViewDataSource
extension EmojisViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.returnEmojisCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojisCollectionViewCell.identifier, for: indexPath) as! EmojisCollectionViewCell
        
        if let emoji = presenter?.getUsedEmoji(at: indexPath.row) {
            cell.configure(url: emoji)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (collectionView.frame.width-25.0)/6.0

        return CGSize(width: width, height: width)
    }
    
}
