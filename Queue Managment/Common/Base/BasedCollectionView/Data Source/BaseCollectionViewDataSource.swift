//
//  BaseCollectionViewDataSource.swift
//  Queue Managment
//
//  Created by WINTAA on 26.07.22.
//

import Foundation
import UIKit

private protocol CollectionViewItemRegistration {
    var cellId: String { get }
    func preconfig(cell: UICollectionViewCell, at indexPath: IndexPath, with model: CellViewModel)
}

class BaseCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    let dataProvider: CollectionDataProvider
    let flowLayoutConstants: CollectionFlowLayoutConstantsProvider
    let collectionView: UICollectionView
    
    private struct CellRegistration<ViewModel: CellViewModel, Cell: ConfigurableCell>:
        CollectionViewItemRegistration {
        let cellId: String
        let preconfigClosure: (Cell, IndexPath, ViewModel) -> Void
        
        func preconfig(cell: UICollectionViewCell,
                       at indexPath: IndexPath,
                       with model: CellViewModel) {
            preconfigClosure(cell as! Cell, indexPath, model as! ViewModel)
        }
        
    }

    private var registrations: [ObjectIdentifier: CollectionViewItemRegistration] = [:]
    
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
        forCell: Cell.Type,
        preconfig: @escaping (Cell, IndexPath, ViewModel) -> Void) {
            let cellId = String(describing: forCell)
            let regId = ObjectIdentifier(item)
            collectionView.register(UINib(nibName: cellId, bundle: nil),             forCellWithReuseIdentifier: cellId)
            
            
            registrations[regId] = CellRegistration(cellId: cellId, preconfigClosure: preconfig)

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
        guard let registration = registrations[regId] else {
            print("collection view item registration \"\(regId)\" not found")
            return UICollectionViewCell()
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: registration.cellId,
                                                      for: indexPath)
        
        registration.preconfig(cell: cell, at: indexPath, with: viewModel)
        
        guard let configCell = cell as? TypeErasedConfigurableCell else {
            print("dequeued cell isn't configurable")
            return UICollectionViewCell()
        }
        
        configCell.configure(viewModel, at: indexPath)
        return cell
    }
    
    func insertItems<ViewModel: CellViewModel>(at indexPath: [IndexPath], items: [ViewModel]){
        dataProvider.insertItems(at: indexPath, item: items)
        collectionView.insertItems(at: indexPath)
    }
    
}

extension BaseCollectionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = calculateCellWidth()
        let height = calculateCellHeight()
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        flowLayoutConstants.edgeInsets
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        flowLayoutConstants.lineSpacing
      }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        flowLayoutConstants.interitemSpacing
    }
    
    private func calculateCellWidth() -> Int{
        var width: CGFloat = 0
        switch flowLayoutConstants.cellWidth {
        case .rawSize(size: let size):
            return size
        case .fixedSize:
            width = collectionView.frame.width
            width -= CGFloat(flowLayoutConstants.itemsCountInLine - 1) * flowLayoutConstants.interitemSpacing
            width -= flowLayoutConstants.edgeInsets.left + flowLayoutConstants.edgeInsets.right
            width /= CGFloat(flowLayoutConstants.itemsCountInLine)
        }
        return Int(width)
    }
    
    private func calculateCellHeight() -> Int {
        var height: CGFloat = 0
        switch flowLayoutConstants.cellHeight {
        case .rawSize(size: let size):
            return size
        case .fixedSize:
            let topinset = collectionView.safeAreaInsets.top
            let bottominset = collectionView.safeAreaInsets.bottom
            height = collectionView.frame.height
            height -= CGFloat(flowLayoutConstants.itemsCountInParLine - 1) * flowLayoutConstants.lineSpacing
            height -= topinset + bottominset
            height /= CGFloat(flowLayoutConstants.itemsCountInParLine)
        }
        return Int(height)
    }
}
