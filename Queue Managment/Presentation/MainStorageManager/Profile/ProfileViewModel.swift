//
//  ProfileViewModel.swift
//  Queue Managment
//
//  Created by WINTAA on 26.07.22.
//

import Foundation

class ProfileViewModel {
    static let texts = [["Profile information", "Change password", "Privacy & terms"],                             ["Log out"]]
    
    let collectionwModel: [[ProfileCellViewModel]] = {
        var model = [[ProfileCellViewModel]]()
        
        for (section, sectionTexts) in texts.enumerated() {
            var newSection = [ProfileCellViewModel]()
            for text in sectionTexts {
                if section == 0 {
                    newSection.append(ProfileCellViewModel(.redirect, text))
                } else {
                    newSection.append(ProfileCellViewModel(.noredirect, text))
                }
            }
            model.append(newSection)
        }
        return model
    }()
}
