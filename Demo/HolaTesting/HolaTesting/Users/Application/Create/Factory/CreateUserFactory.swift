//
//  CreateUserFactory.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 1/5/23.
//

import Foundation
import Swinject

class CreateUserFactory {
    static func createUser() -> CreateUserViewController {
        let dependencies = Container()
        dependencies.register(UserRepository.self) { _ in RealmUserRepository() }
        dependencies.register(NameValidator.self) { _ in NameValidator() }
        dependencies.register(PhoneValidator.self) { _ in PhoneValidator() }
        dependencies.register(EmailValidator.self) { _ in EmailValidator() }
        
        let createUserVM = CreateUserViewModel(dependencies: dependencies)
        let viewController = CreateUserViewController(viewModel: createUserVM)
        return viewController
    }
}
