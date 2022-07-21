//
//  ProfileViewController.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 21.07.22.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil),                       forCellWithReuseIdentifier: "CollectionViewCell")
        setUpBarButton()
        
    }
    private func configureLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    private func setUpBarButton () {
        let backButton = UIButton(type: .custom)
        if let image = UIImage(named: "Bell_tabbar_item") {
            backButton.setImage(image, for: .normal)
        }
        
        let rightItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.rightBarButtonItem = rightItem
    }
}

extension ProfileViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//      let topinset = collectionView.safeAreaInsets.top
//      let bottominset = collectionView.safeAreaInsets.bottom
      let width = CGFloat(collectionView.frame.width)
      let height = CGFloat(64)
      return CGSize(width: Int(width),
             height: Int(height) / 1)
    }
}

extension ProfileViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.label.text = "zura"
        return cell
    }
    
    
}
