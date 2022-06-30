//
//  EmailActionSheetPresenter.swift
//  Queue Managment
//
//  Created by WINTAA on 30.06.22.
//

import Foundation
import UIKit

class EmailActionSheetPresenter {
    
    
    var chooseEmailActionSheet: UIAlertController! {
        didSet {
            presentingController = chooseEmailActionSheet.presentingViewController
        }
    }
    var presentingController: UIViewController!
    
    init(){
        setupChooseEmailActionSheet()
    }
    
    func setupChooseEmailActionSheet(withTitle title: String? = "Choose email") {
        let openableActions = openableActions()
        if openableActions.isEmpty {
            chooseEmailActionSheet = UIAlertController(title: "E-mail app not detected", message: nil, preferredStyle: .alert)
            chooseEmailActionSheet.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
        } else {
            chooseEmailActionSheet = UIAlertController(title: "Choose email", message: nil, preferredStyle: .actionSheet)
            chooseEmailActionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            openableActions.forEach{
                if let action = $0 {
                    chooseEmailActionSheet.addAction(action)
                }
            }
        }
    }
    
    fileprivate func openableActions() -> [UIAlertAction?]{
        var openableActions = [UIAlertAction?]()
        openableActions.append(addOpenAction(withURL: "mailto:", andTitleActionTitle: "Mail"))
        openableActions.append(addOpenAction(withURL: "googlegmail:///", andTitleActionTitle: "Gmail"))
        openableActions.append(addOpenAction(withURL: "inbox-gmail://", andTitleActionTitle: "Inbox"))
        openableActions.append(addOpenAction(withURL: "ms-outlook://", andTitleActionTitle: "Outlook"))
        return openableActions
    }
    
    func addOpenAction(withURL: String, andTitleActionTitle: String) -> UIAlertAction? {
        let completionHandler = { (completed: Bool) in
            LoginWireFrame.showCodeEnterSceen(for: self.presentingController)
        }
         guard let url = URL(string: withURL), UIApplication.shared.canOpenURL(url) else {
              return nil
         }
         let action = UIAlertAction(title: andTitleActionTitle, style: .default) { (action) in
             UIApplication.shared.open(url, options: [:], completionHandler: completionHandler)
         }
         return action
    }
    
    
}
