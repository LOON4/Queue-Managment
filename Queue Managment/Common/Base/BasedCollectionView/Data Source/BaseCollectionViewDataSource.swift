//
//  BaseCollectionViewDataSource.swift
//  Queue Managment
//
//  Created by WINTAA on 26.07.22.
//

import Foundation
import UIKit

class BaseCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    let dataProvider: CollectionDataProvider
    let flowLayoutConstants: CollectionFlowLayoutConstantsProvider
    let collectionView: UICollectionView

    private var registrations: [ObjectIdentifier: String] = [:]
    
    init(collectionView: UICollectionView,
         dataProvider: CollectionDataProvider,
         flowLayoutConstants: CollectionFlowLayoutConstantsProvider) {
        self.collectionView = collectionView
        self.dataProvider = dataProvider
        self.flowLayoutConstants = flowLayoutConstants
        super.init()
        setUpDelegates()
    }
    
    private func setUpDelegates(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    func registerCell<ViewModel: CellViewModel, Cell: ConfigurableCell>(
        item: ViewModel.Type,
        forCell: Cell.Type) {
            let cellId = String(describing: forCell)
            let regId = ObjectIdentifier(item)
            collectionView.register(UINib(nibName: cellId, bundle: nil),             forCellWithReuseIdentifier: cellId)
            registrations[regId] = cellId

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataProvider.numberOfSections()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataProvider.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let viewModel = dataProvider.item(at: indexPath) else {
            print("ViewModel not found")
            return UICollectionViewCell()
        }
        
        let regId = ObjectIdentifier(type(of: viewModel))
        guard let cellId = registrations[regId] else {
            print("collection view item registration \"\(regId)\" not found")
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId,
                                                      for: indexPath)
        guard let configCell = cell as? TypeErasedConfigurableCell else {
            print("dequeued cell isn't configurable")
            return UICollectionViewCell()
        }
        configCell.configure(viewModel, at: indexPath)
        return cell
    }
}

extension BaseCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var width = 0
        var height = 0
        
        let topinset = collectionView.safeAreaInsets.top
        let bottominset = collectionView.safeAreaInsets.bottom
        
        switch flowLayoutConstants.cellHeight {
        case .rawSize(size: let size):
            height = size
        case .fixedSize:
            height = Int(collectionView.frame.width - CGFloat(flowLayoutConstants.itemsCountInLine - 1) - topinset - bottominset)
        }
        
        switch flowLayoutConstants.cellWidth {
        case .rawSize(size: let size):
            width = size
        case .fixedSize:
            width = Int(collectionView.frame.width - CGFloat(flowLayoutConstants.itemsCountInLine - 1))
        }
        
        return CGSize(width: width / flowLayoutConstants.itemsCountInLine, height: height)
    }
}
