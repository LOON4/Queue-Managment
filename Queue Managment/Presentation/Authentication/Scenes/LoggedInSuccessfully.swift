//
//  LoggedInSuccessfully.swift
//  Queue Managment
//
//  Created by WINTAA on 02.07.22.
//

import Foundation
import UIKit

class LoggedInSuccessfully : UIViewController {
    
    static var count = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    @IBAction func service1Clicked(_ sender: Any) {
        LoggedInSuccessfully.count += 1
        let service1 = Service1(serviceName: "gaketeba+\(LoggedInSuccessfully.count)", servicePrice: 200)
        service1.execute{ result in
            switch result {
            case .success(let serviceResponse):
                print(serviceResponse)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @IBAction func service2Clicked(_ sender: Any) {
        let service2 = GSMPartRequestService(page: 0, pageSize: 25)
        service2.execute {result in
            switch result {
            case .success(let serviceResponse):
                print(serviceResponse.content)
            case .failure(let error):
                print(error)
            }
        }
    }
}
