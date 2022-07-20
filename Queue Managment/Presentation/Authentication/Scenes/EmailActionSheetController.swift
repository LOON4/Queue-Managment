//
//  EmailActionSheetController.swift
//  Queue Managment
//
//  Created by WINTAA on 30.06.22.
//

import Foundation
import UIKit
import Resolver

class EmailActionSheetController {
        
    private let mailUrlData = ["mailto:" : "Mail",
                               "googlegmail:///" : "Gmail",
                               "inbox-gmail://" : "Inbox",
                               "ms-outlook://" : "Outlook"]
    var openableUrls: [URL: String] = [URL: String]()
    
    private var chooseEmailActionSheet: UIAlertController
    private var presentingController: CheckEmailController!

        
    init(presentingController: CheckEmailController) {
        self.presentingController = presentingController
        self.chooseEmailActionSheet = UIAlertController(title: "Choose email", message: nil,
                                            preferredStyle: .actionSheet)
        commoninit()
    }
    
    func present(){
        presentingController.present(chooseEmailActionSheet, animated: true, completion: nil)
    }
    
    private func commoninit(){
        configureOpenableUrls()
        setupChooseEmailActionSheet()
    }
        
    private func configureOpenableUrls(){
        mailUrlData.forEach {
            if let url = URL(string: $0.key), UIApplication.shared.canOpenURL(url) {
                openableUrls[url] = $0.value
            }
        }
    }
    
    func setupChooseEmailActionSheet() {
        openableUrls.forEach {
            addOpenAction(withURL: $0.key, andTitleActionTitle: $0.value)
        }
    }
    
    func addOpenAction(withURL url: URL, andTitleActionTitle: String) {
        let completionHandler = { (completed: Bool) in
            self.presentingController.checkEmailViewModel.navigateToCheckCode()
        }

        let action = UIAlertAction(title: andTitleActionTitle, style: .default) { (action) in
            UIApplication.shared.open(url, options: [:], completionHandler: completionHandler)
        }
        chooseEmailActionSheet.addAction(action)
    }
    
    
}
