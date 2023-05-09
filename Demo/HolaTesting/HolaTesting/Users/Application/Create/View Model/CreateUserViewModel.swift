//
//  CreateUserViewModel.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import UIKit
import Swinject

protocol CreateUserDelegate: AnyObject {
    func enableCreate(enabled: Bool)
    func successCreate(message: String)
    func showCreateError(errorMessage: String)
}

class CreateUserViewModel {
    
    weak var delegate: CreateUserDelegate?
    
    private (set) var user = User()
    
    private let repository: UserRepository
    private let nameValidator: NameValidator
    private let phoneValidator: PhoneValidator
    private let emailValidator: EmailValidator
    
    internal var isRequiredFieldsFilled: Bool {
        return isNameFilled && isLastNameFilled && isPhoneNumberFilled
//        return isNameFilled && isLastNameFilled && isPhoneNumberFilled && isEmailFilled
    }
    
    internal var isNameFilled: Bool {
        return !user.name.isEmpty
    }
    
    internal var isLastNameFilled: Bool {
        return !user.lastName.isEmpty
    }
    
    internal var isPhoneNumberFilled: Bool {
        return !user.phoneNumber.isEmpty
    }
    
    internal var isEmailFilled: Bool {
        return true
//        return !user.email.isEmpty
    }
    
    init(dependencies: Container) {
        self.repository = dependencies.resolve(UserRepository.self)!
        self.nameValidator = dependencies.resolve(NameValidator.self)!
        self.phoneValidator = dependencies.resolve(PhoneValidator.self)!
        self.emailValidator = dependencies.resolve(EmailValidator.self)!
    }
    
    init(repository: UserRepository, nameValidator: NameValidator, phoneValidator: PhoneValidator, emailValidator: EmailValidator) {
        self.repository = repository
        self.nameValidator = nameValidator
        self.phoneValidator = phoneValidator
        self.emailValidator = emailValidator
    }
    
    func update(name: String) {
        user.name = name
        delegate?.enableCreate(enabled: isRequiredFieldsFilled)
    }
    
    func update(lastName: String) {
        user.lastName = lastName
        delegate?.enableCreate(enabled: isRequiredFieldsFilled)
    }
    
    func update(phoneNumber: String) {
        user.phoneNumber = phoneNumber
        delegate?.enableCreate(enabled: isRequiredFieldsFilled)
    }
    
    func update(email: String) {
//        user.email = email
//        delegate?.enableCreate(enabled: isRequiredFieldsFilled)
    }
    
    func update(address: String) {
        user.address = address
    }
    
    func didTapSave() {
        do {
            try validateFields()
            try saveUser()
        } catch let error as ValidationError {
            delegate?.showCreateError(errorMessage: error.messageError)
        } catch let error as RepositoryError {
            delegate?.showCreateError(errorMessage: error.messageError)
        } catch {
            delegate?.showCreateError(errorMessage: RepositoryError.unexpected.messageError)
        }
    }

    internal func saveUser() throws {
        try repository.add(user)
        
        let successMessage = String(format: "user_created".localized, user.name)
        delegate?.successCreate(message: successMessage)
    }
    
    internal func validateFields() throws {
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
//        return ValidationError.error(message: String(format: "\("email".localized): %@", messageError))
//    }
}
