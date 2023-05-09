//
//  EditUserFactory.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 1/5/23.
//

import Foundation
import Swinject

class EditUserFactory {
    static func editUser(user: User) -> EditUserViewController {
        let dependencies = Container()
        dependencies.register(UserRepository.self) { _ in RealmUserRepository() }
        dependencies.register(NameValidator.self) { _ in NameValidator() }
        dependencies.register(PhoneValidator.self) { _ in PhoneValidator() }
        dependencies.register(EmailValidator.self) { _ in EmailValidator() }
        
        let viewModel = EditUserViewModel(user: user, dependencies: dependencies)
        let viewController = EditUserViewController(viewModel: viewModel)
        
        return viewController
    }
}
