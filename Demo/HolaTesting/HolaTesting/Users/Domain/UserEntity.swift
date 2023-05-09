//
//  UserEntity.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import Foundation
import RealmSwift

class UserEntity: Object {
    
    @Persisted(primaryKey: true) var id = UUID().uuidString
    @Persisted var name: String
    @Persisted var lastName: String
    @Persisted var phoneNumber: String
    @Persisted var address: String?
//    @Persisted var email: String
    
    convenience init(_ user: User) {
        self.init()
        
        self.id = user.id
        self.name = user.name
        self.lastName = user.lastName
        self.phoneNumber = user.phoneNumber
        self.address = user.address
//        self.email = user.email
    }
    
    convenience init(name: String = "", lastName: String = "", phoneNumber: String = "", email: String = "", address: String? = nil) {
        self.init()
        
        self.name = name
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.address = address
//        self.email = email
    }
}
