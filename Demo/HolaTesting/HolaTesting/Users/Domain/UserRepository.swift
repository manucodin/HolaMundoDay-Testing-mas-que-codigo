//
//  UserRepository.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import Foundation

protocol UserRepository {
    func add(_ user: User) throws
    func fetch() -> [User]
    func update(_ user: User) throws
    func delete(_ user: User) throws
}
