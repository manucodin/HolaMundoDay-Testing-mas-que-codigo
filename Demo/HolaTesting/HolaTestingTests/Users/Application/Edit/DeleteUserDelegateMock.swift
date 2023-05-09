//
//  DeleteUserDelegateMock.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 1/5/23.
//

import Foundation

@testable import HolaTesting

class DeleteUserDelegateMock: DeleteUserDelegate {

    var invokedSuccessDelete = false
    var invokedSuccessDeleteCount = 0
    var invokedSuccessDeleteParameters: (message: String, Void)?
    var invokedSuccessDeleteParametersList = [(message: String, Void)]()

    func successDelete(message: String) {
        invokedSuccessDelete = true
        invokedSuccessDeleteCount += 1
        invokedSuccessDeleteParameters = (message, ())
        invokedSuccessDeleteParametersList.append((message, ()))
    }

    var invokedShowDeleteError = false
    var invokedShowDeleteErrorCount = 0
    var invokedShowDeleteErrorParameters: (errorMessage: String, Void)?
    var invokedShowDeleteErrorParametersList = [(errorMessage: String, Void)]()

    func showDeleteError(errorMessage: String) {
        invokedShowDeleteError = true
        invokedShowDeleteErrorCount += 1
        invokedShowDeleteErrorParameters = (errorMessage, ())
        invokedShowDeleteErrorParametersList.append((errorMessage, ()))
    }
}
