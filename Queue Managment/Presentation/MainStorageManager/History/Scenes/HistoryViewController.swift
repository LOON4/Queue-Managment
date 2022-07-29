//
//  HistoryViewController.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 18.07.22.
//

import Foundation
import UIKit
import Resolver
import Combine

class HistoryViewController : UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var justView: RotatableView!
    @IBOutlet weak var viewWithBorder: RotatableView!
    
    @IBOutlet weak var currentRequestCV: UICollectionView!
    var currentRequestCVDataSource: BaseCollectionViewDataSource? = nil
    
    @LazyInjected var historyViewModel: HistoryViewModel
    private var bindings = Set<AnyCancellable>()
    private var loader: LoaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBorder()
        setLabel()
        setUpBarButton()
        setUpCollectionView()
        setUpBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLoader()
        fetchFirstPage()
    }

    
    private func setUpBindings() {
        func bindViewModelToView() {
            historyViewModel.$isLoading
                .dropFirst()
                .sink { [weak self] isLoading in
                    if isLoading {
                        if self?.historyViewModel.currentCount == 0 {
                            self?.loader.startLoader()
                        } else {
                            
                        }
                    } else {
                        if self?.historyViewModel.currentPage == 0 {
                            self?.loader.stopLoader()
                        } else {
                            
                        }
                    }
                }
                .store(in: &bindings)
            
            historyViewModel.validationResult
                .sink { [weak self] receiveValue in
                    self?.updateCVrows(at: receiveValue.0, viewModels: receiveValue.1)
                }
                .store(in: &bindings)
        }
        bindViewModelToView()
    }
    
    private func setUpCollectionView(){
        
        currentRequestCVDataSource = BaseCollectionViewDataSource(
            collectionView: currentRequestCV,
            dataProvider: ArrayDataProvider(array: [historyViewModel.partRequestCellViewModels]),
            flowLayoutConstants: CollectionFlowLayoutConstantsProvider(
                lineSpacing: 24,
                cellHeight: .rawSize(size: 150),
                edgeInsets: UIEdgeInsets(top: 24,
                                         left: 16,
                                         bottom: 24,
                                         right: 16)))
        
        currentRequestCVDataSource?.registerCell(item: PartRequestViewModel.self,
                                                 forCell: PartRequestCell.self) {
            [weak self] cell, indexPath, viewModel in
            
            if indexPath.row + 1 == self?.historyViewModel.partRequestCellViewModels.count {
                self?.historyViewModel.fetchNextPartRequestsPage()
            }
            
        }

    }
    
    private func fetchFirstPage() {
        if historyViewModel.firstFetchPerfomed == false {
            historyViewModel.fetchNextPartRequestsPage()
            historyViewModel.firstFetchPerfomed = true
        }
    }
    
    private func updateCVrows(at indexPath: [IndexPath], viewModels: [PartRequestViewModel]){
        currentRequestCVDataSource?.insertItems(at: indexPath, items: viewModels)
    }
    
    private func setupLoader() {
        if loader == nil {
            loader = LoaderView(currentRequestCV)
            loader.stopLoader()
        }
    }
    
    private func setUpBarButton () {
        let backButton = UIButton(type: .custom)
        if let image = UIImage(named: "Bell_tabbar_item") {
            backButton.setImage(image, for: .normal)
        }
        
        let rightItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.rightBarButtonItem = rightItem
    }
    
    func setBorder() {
        viewWithBorder.layer.borderWidth = 1.0
        viewWithBorder.layer.borderColor = UIColor(red: CGFloat(0/255.0), green: CGFloat(120/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(0.44)).cgColor
    }
    
    func setLabel() {
        let range = NSRange(location:9,length:1)
        let attributedString = NSMutableAttributedString(string: "You have 0 requests at the moment.")
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: CGFloat(0/255.0), green: CGFloat(122/255.0), blue: CGFloat(255/255.0), alpha: CGFloat(1)), range: range)
         label.attributedText = attributedString
    }    
}
    

