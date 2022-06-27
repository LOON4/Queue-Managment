//
//  UIButtonConfiguration.swift
//  Queue Managment
//
//  Created by WINTAA on 26.06.22.
//

import Foundation
import UIKit

extension UIButton.Configuration {
    static func navigationBarButtonTemplate() -> UIButton.Configuration {
        let backButton = UIButton()
        backButton.configuration = .plain()
        backButton.configuration?.attributedTitle = "Back"
        backButton.configuration?.attributedTitle?.font = UIFont.SanFranciscoRegular(size: 17)
        backButton.configuration?.attributedTitle?.strokeColor = .black

        var image = UIImage(systemName: "arrow.backward")
        image = image?.resizedImage(Size: CGSize(width: 20, height: 15))
        backButton.configuration?.image = image
        backButton.configuration?.baseForegroundColor = .black
        backButton.configuration?.imagePadding = 2
        backButton.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 100)
        return backButton.configuration!
    }

}
