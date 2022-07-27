//
//  ArrayDataProvider.swift
//  Queue Managment
//
//  Created by WINTAA on 26.07.22.
//

import Foundation

class ArrayDataProvider: CollectionDataProvider {
    
    // MARK: - Internal Properties
    var items: [[CellViewModel]] = []

    // MARK: - Lifecycle
    init(array: [[CellViewModel]]) {
        items = array
    }

    // MARK: - CollectionDataProvider
    func numberOfSections() -> Int {
        return items.count
    }

    func numberOfItems(in section: Int) -> Int {
        guard section >= 0 && section < items.count else {
            return 0
        }
        return items[section].count
    }

    func item(at indexPath: IndexPath) -> CellViewModel? {
        guard indexPath.section >= 0 && indexPath.section < items.count &&
            indexPath.row >= 0 && indexPath.row < items[indexPath.section].count else {
            return nil
        }
        return items[indexPath.section][indexPath.row]
    }
}
