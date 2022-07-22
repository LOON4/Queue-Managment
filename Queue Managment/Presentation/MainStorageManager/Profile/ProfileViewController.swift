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
    let collectionViewModel = [["Profile information", "Change password", "Privacy & terms"],                             ["Log out"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBarButton()
        setUpCollectionView()
    }
    
    private func setUpCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ProfileCell", bundle: nil),             forCellWithReuseIdentifier: "ProfileCell")

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

extension ProfileViewController : UICollectionViewDataSource,
                                  UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        collectionViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        collectionViewModel[section].count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCell",
                                                      for: indexPath)
        let text = collectionViewModel[indexPath.section][indexPath.row]
        if let profileCell = cell as? ProfileCell {
            if indexPath.section == 0 {
                profileCell.configure(with: text, for: .redirect)
            } else {
                profileCell.configure(with: text, for: .noredirect)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - (2 * Constants.spacing) -
        CGFloat(Constants.itemsCountInLine - 1) * Constants.spacing
        return CGSize(width: Int(width) / Constants.itemsCountInLine, height: 64)
    }
    
}

extension ProfileViewController {
    struct Constants {
        static let itemsCountInLine = 1
        static let spacing: CGFloat = 0
    }
}
