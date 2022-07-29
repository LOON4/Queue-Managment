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
    var itemsCountInParLine: Int
    var lineSpacing: CGFloat
    var interitemSpacing: CGFloat
    var cellHeight: CellSize
    var cellWidth: CellSize
    var edgeInsets: UIEdgeInsets
    
    init(itemsCountInLine: Int = 1,
         itemsCountInParLine: Int = 1,
         lineSpacing: CGFloat = 0,
         interitemSpacing: CGFloat = 0,
         cellHeight: CellSize = .fixedSize,
         cellWidth: CellSize = .fixedSize,
         edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 0,
                                                 left: 0,
                                                 bottom: 0,
                                                 right: 0)){
        self.itemsCountInLine = itemsCountInLine
        self.itemsCountInParLine = itemsCountInParLine
        self.lineSpacing = lineSpacing
        self.interitemSpacing = interitemSpacing
        self.cellHeight = cellHeight
        self.cellWidth = cellWidth
        self.edgeInsets = edgeInsets
    }
}
