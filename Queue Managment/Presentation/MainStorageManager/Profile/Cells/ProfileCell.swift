//
//  ProfileCell.swift
//  Queue Managment
//
//  Created by WINTAA on 22.07.22.
//

import UIKit

class ProfileCell: UICollectionViewCell, ConfigurableCell {
    
    @IBOutlet weak var redirectButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var viewModel: ProfileCellViewModel!
    
    var currentState: profileCellState = .redirect {
        didSet {
            switch currentState {
            case .redirect:
                redirectButton.isHidden = false
                label.font = UIFont.SanFranciscoMedium(size: 17)
            case .noredirect:
                redirectButton.isHidden = true
                label.font = UIFont.SanFranciscoBold(size: 17)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        redirectButton.imageView?.tintColor = .black
        redirectButton.imageView?.contentMode = .scaleAspectFit
    }
    
    func configure(_ item: ProfileCellViewModel, at indexPath: IndexPath){
        self.viewModel = item
        self.label.text = viewModel.text
        self.currentState = viewModel.currentState
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
}
