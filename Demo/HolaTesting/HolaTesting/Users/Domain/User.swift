//
//  User.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import Foundation

struct User {
    private(set) var id: String = UUID().uuidString
    var name: String
    var lastName: String
    var phoneNumber: String
    var address: String?
//    var email: String
    
    init(_ entity: UserEntity) {
        self.id = entity.id
        self.name = entity.name
        self.lastName = entity.lastName
        self.phoneNumber = entity.phoneNumber
        self.address = entity.address
//        self.email = entity.email
    }

    init(name: String = "", lastName: String = "", phoneNumber: String = "", email: String = "", address: String? = nil) {
        self.name = name
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.address = address
//        self.email = email
    }
}
