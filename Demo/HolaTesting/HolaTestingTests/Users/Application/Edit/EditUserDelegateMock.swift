//
//  EditUserDelegateMock.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 1/5/23.
//

import Foundation

@testable import HolaTesting

class EditUserDelegateMock: EditUserDelegate {

    var invokedEnableSave = false
    var invokedEnableSaveCount = 0
    var invokedEnableSaveParameters: (enabled: Bool, Void)?
    var invokedEnableSaveParametersList = [(enabled: Bool, Void)]()

    func enableSave(enabled: Bool) {
        invokedEnableSave = true
        invokedEnableSaveCount += 1
        invokedEnableSaveParameters = (enabled, ())
        invokedEnableSaveParametersList.append((enabled, ()))
    }

    var invokedSuccessEdit = false
    var invokedSuccessEditCount = 0
    var invokedSuccessEditParameters: (message: String, Void)?
    var invokedSuccessEditParametersList = [(message: String, Void)]()

    func successEdit(message: String) {
        invokedSuccessEdit = true
        invokedSuccessEditCount += 1
        invokedSuccessEditParameters = (message, ())
        invokedSuccessEditParametersList.append((message, ()))
    }

    var invokedShowUpdateError = false
    var invokedShowUpdateErrorCount = 0
    var invokedShowUpdateErrorParameters: (errorMessage: String, Void)?
    var invokedShowUpdateErrorParametersList = [(errorMessage: String, Void)]()

    func showUpdateError(errorMessage: String) {
        invokedShowUpdateError = true
        invokedShowUpdateErrorCount += 1
        invokedShowUpdateErrorParameters = (errorMessage, ())
        invokedShowUpdateErrorParametersList.append((errorMessage, ()))
    }
}
