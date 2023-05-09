//
//  RealmUserRepositoryMock.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 23/4/23.
//

import Foundation

@testable import HolaTesting

class RealmUserRepositoryMock: UserRepository {

    var invokedAdd = false
    var invokedAddCount = 0
    var invokedAddParameters: (user: User, Void)?
    var invokedAddParametersList = [(user: User, Void)]()
    var stubbedAddError: Error?

    func add(_ user: User) throws {
        invokedAdd = true
        invokedAddCount += 1
        invokedAddParameters = (user, ())
        invokedAddParametersList.append((user, ()))
        if let error = stubbedAddError {
            throw error
        }
    }

    var invokedFetch = false
    var invokedFetchCount = 0
    var stubbedFetchResult: [User]! = []

    func fetch() -> [User] {
        invokedFetch = true
        invokedFetchCount += 1
        return stubbedFetchResult
    }

    var invokedUpdate = false
    var invokedUpdateCount = 0
    var invokedUpdateParameters: (user: User, Void)?
    var invokedUpdateParametersList = [(user: User, Void)]()

    func update(_ user: User) {
        invokedUpdate = true
        invokedUpdateCount += 1
        invokedUpdateParameters = (user, ())
        invokedUpdateParametersList.append((user, ()))
    }

    var invokedDelete = false
    var invokedDeleteCount = 0
    var invokedDeleteParameters: (user: User, Void)?
    var invokedDeleteParametersList = [(user: User, Void)]()

    func delete(_ user: User) {
        invokedDelete = true
        invokedDeleteCount += 1
        invokedDeleteParameters = (user, ())
        invokedDeleteParametersList.append((user, ()))
    }
}
