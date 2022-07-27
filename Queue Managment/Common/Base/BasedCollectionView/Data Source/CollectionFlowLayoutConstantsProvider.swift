//
//  CollectionFlowLayoutProvider.swift
//  Queue Managment
//
//  Created by WINTAA on 26.07.22.
//

import Foundation
import UIKit

enum CellSize {
    case fixedSize
    case rawSize(size: Int)
}

class CollectionFlowLayoutConstantsProvider {
    
    var itemsCountInLine: Int
    var cellHeight: CellSize
    var cellWidth: CellSize
    
    init(itemsCountInLine: Int = 1,
         cellHeight: CellSize = .fixedSize,
         cellWidth: CellSize = .fixedSize){
        self.itemsCountInLine = itemsCountInLine
        self.cellHeight = cellHeight
        self.cellWidth = cellWidth
    }
}
