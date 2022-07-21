//
//  StorageViewController.swift
//  Queue Managment
//
//  Created by Zura Tvaradze on 21.07.22.
//

import Foundation
import UIKit


class StorageViewController : UIViewController {
    
    
    @IBOutlet weak var SearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.isTranslucent = false
    }
}
