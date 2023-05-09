//
//  UserListFactory.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 1/5/23.
//

import Foundation
import Swinject

class UserListFactory {
    static func userList() -> UsersListViewController {
        let dependencies = Container()
        dependencies.register(UserRepository.self) { _ in RealmUserRepository() }
        
        let userListVM = UserListViewModel(dependencies: dependencies)
        let viewController = UsersListViewController(viewModel: userListVM)
        
        return viewController
    }
}
