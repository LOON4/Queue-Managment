//
//  UserRole.swift
//  Queue Managment
//
//  Created by WINTAA on 27.07.22.
//

import Foundation

enum UserRolesEnum: String, CaseIterable{
    case ACCOUNTANT;
    case CASHIER;
    case CEO;
    case DIRECTOR;
    case GACCOUNTANT;
    case GSM;
    case HR;
    case MECHANIC;
    case RECEPTIONIST;
    case SMANAGER;
    case STORAGEM;
    case UNKNOWN;
}

class UserRole {
    static func getRole() -> UserRolesEnum {
        let decodedToken = Token.shared?.decodeToken()
        guard let realmacess = decodedToken?["realm_access"] as? [String: Any],
              let roles = realmacess["roles"] as? [String] else {
            return .UNKNOWN
        }
        
        for role in UserRolesEnum.allCases {
            if roles.contains(role.rawValue) {
                return role
            }
        }
        return .UNKNOWN
    }
    
}
