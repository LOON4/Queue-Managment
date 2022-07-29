//
//  ProfileViewController.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 21.07.22.
//

import Foundation
import UIKit
import Resolver

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @LazyInjected var profileViewModel: ProfileViewModel
    var collectionViewDataSource: BaseCollectionViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBarButton()
        setUpCollectionView()
    }
    
    private func setUpCollectionView(){
        
        collectionViewDataSource = BaseCollectionViewDataSource(
            collectionView: collectionView,
            dataProvider: ArrayDataProvider(array: profileViewModel.collectionwModel),
            flowLayoutConstants: CollectionFlowLayoutConstantsProvider(
                cellHeight: .rawSize(size: 64)))
        
        collectionViewDataSource.registerCell(item: ProfileCellViewModel.self,
                                              forCell: ProfileCell.self,
                                              preconfig: { _,_,_  in })

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
