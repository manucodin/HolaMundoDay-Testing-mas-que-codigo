//
//  UserCellViewModel.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import Foundation

class UserCellViewModel {
    
    var mainText: String {
        return "\(user.name) \(user.lastName)"
    }
    
    var secondaryText: String {
        return String(format: "phone_formated".localized, "\(user.phoneNumber)")
    }
    
    private let user: User
    
    init(_ user: User) {
        self.user = user
    }
}
