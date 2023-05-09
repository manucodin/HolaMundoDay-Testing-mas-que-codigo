//
//  UserListDelegateMock.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 23/4/23.
//

import Foundation

@testable import HolaTesting

class UserListDelegateMock: UserListDelegate {

    var invokedShowEmptyState = false
    var invokedShowEmptyStateCount = 0

    func showEmptyState() {
        invokedShowEmptyState = true
        invokedShowEmptyStateCount += 1
    }

    var invokedHideEmptyState = false
    var invokedHideEmptyStateCount = 0

    func hideEmptyState() {
        invokedHideEmptyState = true
        invokedHideEmptyStateCount += 1
    }
}
