//
//  Loader.swift
//  Queue Managment
//
//  Created by WINTAA on 17.07.22.
//

import Foundation
import UIKit

class LoaderView: BasedComponentView {
    
    @IBOutlet weak var loaderIndicator: UIImageView!
    @IBOutlet weak var pleasWaitLabel: UILabel!
    
    var superView: UIView
    
    init(_ superView: UIView) {
        self.superView = superView
        super.init(frame: superView.frame)
        superView.addSubview(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUp() {

    }
    
    func startLoader(){
        self.isHidden = false
        super.isUserInteractionEnabled = false
        startRotating()
    }
    
    func stopLoader() {
        self.isHidden = true
        superView.isUserInteractionEnabled = true
    }
    
    private func startRotating(){
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(.pi * 2.0)
        rotateAnimation.duration = 2
        rotateAnimation.repeatCount = .infinity
        loaderIndicator.layer.add(rotateAnimation, forKey: nil)
    }
    
}
