//
//  ProfileCellViewModel.swift
//  Queue Managment
//
//  Created by WINTAA on 26.07.22.
//

import Foundation

enum profileCellState {
    case redirect
    case noredirect
}

class ProfileCellViewModel: CellViewModel {
    var currentState: profileCellState
    var text: String
    
    init(_ currentState: profileCellState, _ text: String){
        self.currentState = currentState
        self.text = text
    }
}
