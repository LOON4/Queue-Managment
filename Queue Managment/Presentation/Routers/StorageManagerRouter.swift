//
//  StorageManagerRouter.swift
//  Queue Managment
//
//  Created by WINTAA on 25.07.22.
//

import UIKit
import Resolver

protocol StorageManagerRouter {
    func showStorageFirstPage()
}

class StorageManagerRouterImpl: StorageManagerRouter {
    private static let storageManagerStoryboard = {
        UIStoryboard(name: StoryboardIDK.storageManager,
                    bundle: .main)
    }()
    
    private static let storageManagerMainTabBar = {
        storageManagerStoryboard.instantiateViewController(withIdentifier: TabControllerIDK.storageManagerTabBar )
    }()
    
    private var presentingController: UIViewController
    
    init(_ presentingController: UIViewController){
        self.presentingController = presentingController
    }
    
    func showStorageFirstPage() {
        StorageManagerRouterImpl.storageManagerMainTabBar.modalPresentationStyle = .overFullScreen
        presentingController.navigationController?.pushViewController(StorageManagerRouterImpl.storageManagerMainTabBar, animated: true)
    }
}
