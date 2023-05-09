//
//  CreateUserDelegateMock.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 23/4/23.
//

import Foundation

@testable import HolaTesting

class CreateUserDelegateMock: CreateUserDelegate {

    var invokedEnableCreate = false
    var invokedEnableCreateCount = 0
    var invokedEnableCreateParameters: (enabled: Bool, Void)?
    var invokedEnableCreateParametersList = [(enabled: Bool, Void)]()

    func enableCreate(enabled: Bool) {
        invokedEnableCreate = true
        invokedEnableCreateCount += 1
        invokedEnableCreateParameters = (enabled, ())
        invokedEnableCreateParametersList.append((enabled, ()))
    }

    var invokedSuccessCreate = false
    var invokedSuccessCreateCount = 0
    var invokedSuccessCreateParameters: (message: String, Void)?
    var invokedSuccessCreateParametersList = [(message: String, Void)]()

    func successCreate(message: String) {
        invokedSuccessCreate = true
        invokedSuccessCreateCount += 1
        invokedSuccessCreateParameters = (message, ())
        invokedSuccessCreateParametersList.append((message, ()))
    }

    var invokedShowCreateError = false
    var invokedShowCreateErrorCount = 0
    var invokedShowCreateErrorParameters: (errorMessage: String, Void)?
    var invokedShowCreateErrorParametersList = [(errorMessage: String, Void)]()

    func showCreateError(errorMessage: String) {
        invokedShowCreateError = true
        invokedShowCreateErrorCount += 1
        invokedShowCreateErrorParameters = (errorMessage, ())
        invokedShowCreateErrorParametersList.append((errorMessage, ()))
    }
}
