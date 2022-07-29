//
//  PartRequestCell.swift
//  Queue Managment
//
//  Created by WINTAA on 28.07.22.
//

import UIKit
import Combine

class PartRequestCell: UICollectionViewCell, ConfigurableCell {
    
    @IBOutlet weak var newRequetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailsButton: UIButton!
    
    var viewModel: PartRequestViewModel!
    private var bindings = Set<AnyCancellable>()
    

    func configure(_ item: PartRequestViewModel, at indexPath: IndexPath) {
        self.viewModel = item
        self.newRequetLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.timeLabel.text = viewModel.time
        setupUI()
        setUpBindings()
    }
    
    private func setUpBindings() {
        func bindModelToModelView() {
            viewModel.$description
            .sink { [weak self] receivedValue in
                self?.descriptionLabel.text = receivedValue
            }
            .store(in: &bindings)
        }
        bindModelToModelView()
    }
    
    private func setupUI(){
        setShadow()
        newRequetLabel.font = UIFont.SanFranciscoMedium(size: 24)
        newRequetLabel.adjustsFontSizeToFitWidth = true
        timeLabel.font = UIFont.SanFranciscoRegular(size: 12)
        descriptionLabel.font = UIFont.SanFranciscoRegular(size: 12)
        detailsButton.titleLabel?.font = UIFont.SanFranciscoRegular(size: 14)
    }

    private func setShadow(){
        self.contentView.layer.cornerRadius = 8.0
        self.contentView.layer.borderWidth = 1.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 8.0
        self.layer.shadowOpacity = 0.14
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
    @IBAction func detailsClicked(_ sender: UIButton) {
    }
    
    override func prepareForReuse() {
        for sub in bindings {
            sub.cancel()
        }
    }
}
