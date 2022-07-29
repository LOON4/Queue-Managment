//
//  CollectionDataProvider.swift
//  Queue Managment
//
//  Created by WINTAA on 26.07.22.
//

import Foundation

protocol CollectionDataProvider {
    func numberOfSections() -> Int
    func numberOfItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> CellViewModel?
    func insertItems(at indexPath: [IndexPath], item: [CellViewModel])
}
