//
//  ConfigurableCell.swift
//  Queue Managment
//
//  Created by WINTAA on 25.07.22.
//

import Foundation
import UIKit

protocol ConfigurableCell: TypeErasedConfigurableCell, ReusableCell {
    associatedtype ViewModelType: CellViewModel

    func configure(_ item: ViewModelType, at indexPath: IndexPath)
}

protocol TypeErasedConfigurableCell {
    func configure(_ viewModel: CellViewModel, at indexPath: IndexPath)
}

extension ConfigurableCell {
    func configure(_ viewModel: CellViewModel, at indexPath: IndexPath) {
        guard let vm = viewModel as? ViewModelType else {
            return
        }
        configure(vm, at: indexPath)
    }
}
