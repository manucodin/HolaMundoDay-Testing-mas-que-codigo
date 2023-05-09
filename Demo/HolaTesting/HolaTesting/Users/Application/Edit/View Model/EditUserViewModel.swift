//
//  EditUserViewModel.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import Foundation
import Swinject

protocol EditUserDelegate: AnyObject {
    func enableSave(enabled: Bool)
    func successEdit(message: String)
    func showUpdateError(errorMessage: String)
}

protocol DeleteUserDelegate: AnyObject {
    func successDelete(message: String)
    func showDeleteError(errorMessage: String)
}

class EditUserViewModel {
    
    weak var editDelegate: EditUserDelegate?
    weak var deleteDelegate: DeleteUserDelegate?
    
    var name: String {
        return user.name
    }
    
    var lastName: String {
        return user.lastName
    }
    
    var phoneNumber: String {
        return user.phoneNumber
    }
    
    var address: String {
        return user.address ?? ""
    }
    
    var email: String {
        return ""
//        return user.email
    }
    
    private (set) var user: User
    private let oldUser: User
    private let repository: UserRepository
    private let nameValidator: NameValidator
    private let phoneValidator: PhoneValidator
    private let emailValidator: EmailValidator
    
    init(user: User, dependencies: Container) {
        self.user = user
        self.oldUser = user
        
        self.repository = dependencies.resolve(UserRepository.self)!
        self.nameValidator = dependencies.resolve(NameValidator.self)!
        self.phoneValidator = dependencies.resolve(PhoneValidator.self)!
        self.emailValidator = dependencies.resolve(EmailValidator.self)!
    }
    
    init(user: User, repository: UserRepository, nameValidator: NameValidator, phoneValidator: PhoneValidator, emailValidator: EmailValidator) {
        self.user = user
        self.oldUser = user
        self.repository = repository
        self.nameValidator = nameValidator
        self.phoneValidator = phoneValidator
        self.emailValidator = emailValidator
    }
    
    func update(name: String) {
        user.name = name
        editDelegate?.enableSave(enabled: oldUser.name != user.name)
    }
    
    func update(lastName: String) {
        user.lastName = lastName
        editDelegate?.enableSave(enabled: oldUser.lastName != user.lastName)
    }
    
    func update(phoneNumber: String) {
        user.phoneNumber = phoneNumber
        editDelegate?.enableSave(enabled: oldUser.phoneNumber != user.phoneNumber)
    }
    
    func update(email: String) {
//        user.email = email
//        editDelegate?.enableSave(enabled: oldUser.email != user.email)
    }
    
    func update(address: String) {
        user.address = address
        editDelegate?.enableSave(enabled: oldUser.address != user.address)
    }
    
    func didTapDelete() {
        do {
            try deleteUser()
        } catch let error as RepositoryError {
            deleteDelegate?.showDeleteError(errorMessage: error.messageError)
        } catch {
            deleteDelegate?.showDeleteError(errorMessage: RepositoryError.unexpected.messageError)
        }
    }
    
    internal func deleteUser() throws {
        try repository.delete(user)
        
        let successMessage = String(format: "user_deleted".localized, user.name)
        deleteDelegate?.successDelete(message: successMessage)
    }
    
    func didTapUpdate() {
        do {
            try updateUser()
        } catch let error as ValidationError {
            editDelegate?.showUpdateError(errorMessage: error.messageError)
        } catch let error as RepositoryError {
            editDelegate?.showUpdateError(errorMessage: error.messageError)
        } catch {
            editDelegate?.showUpdateError(errorMessage: RepositoryError.unexpected.messageError)
        }
    }
    
    internal func updateUser() throws {
        try validateField()
        try repository.update(user)
        
        let successMessage = String(format: "user_updated".localized, user.name)
        editDelegate?.successEdit(message: successMessage)
    }
    
    internal func validateField() throws {
        let errorMessage = [validateName(), validateLastName(), validatePhone()].compactMap({ $0?.messageError })
//        let errorMessage = [validateName(), validateLastName(), validatePhone(), validateEmail()].compactMap({ $0?.messageError })
        let formattedErrorMessage = errorMessage.joined(separator: "\n")
        
        if !formattedErrorMessage.isEmpty {
            throw ValidationError.error(message: formattedErrorMessage)
        }
    }
    
    internal func validateName() -> ValidationError? {
        guard let messageError = nameValidator.validate(user.name)?.messageError else { return nil }
        
        return ValidationError.error(message: String(format: "\("name".localized): %@", messageError))
    }
    
    internal func validateLastName() -> ValidationError? {
        guard let messageError = nameValidator.validate(user.lastName)?.messageError else { return nil }
        
        return ValidationError.error(message: String(format: "\("lastName".localized): %@", messageError))
    }
    
    internal func validatePhone() -> ValidationError? {
        guard let messageError = phoneValidator.validate(user.phoneNumber)?.messageError else { return nil }
        
        return ValidationError.error(message: String(format: "\("phoneNumber".localized): %@", messageError))
    }
    
//    internal func validateEmail() -> ValidationError? {
//        guard let messageError = emailValidator.validate(user.email)?.messageError else { return nil }
//
//        return ValidationError.error(message: String(format: "\("phoneNumber".localized): %@", messageError))
//    }
}
