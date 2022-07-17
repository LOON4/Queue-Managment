//
//  BasedComponentView.swift
//  Contacts
//
//  Created by WINTAA on 13.04.22.
//

import UIKit

class BasedComponentView : UIView{
    
    @IBOutlet weak var contentView : UIView!

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let bundle = Bundle(for: Self.self)
        bundle.loadNibNamed(String(describing: Self.self), owner: self, options: nil)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(contentView)
    }
    
    func setUp() {
        
    }
    
}
