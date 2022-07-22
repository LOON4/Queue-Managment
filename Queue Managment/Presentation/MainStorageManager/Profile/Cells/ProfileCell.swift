//
//  ProfileCell.swift
//  Queue Managment
//
//  Created by WINTAA on 22.07.22.
//

import UIKit

class ProfileCell: UICollectionViewCell {

    enum profileCellState {
        case redirect
        case noredirect
    }
    
    @IBOutlet weak var redirectButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
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
        redirectButton.imageView?.contentMode = .scaleAspectFit
    }
    
    func configure (with text: String, for state: profileCellState){
        self.currentState = state
        self.label.text = text
    }

}
