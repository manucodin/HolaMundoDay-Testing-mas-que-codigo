//
//  UserListViewModel.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import UIKit
import Swinject

protocol UserListDelegate: AnyObject {
    func showEmptyState()
    func hideEmptyState()
}

class UserListViewModel: NSObject {
    
    weak var delegate: UserListDelegate?
    
    private (set) var users = [User]()
    private let repository: UserRepository
    
    var isEmpty: Bool {
        return users.isEmpty
    }
    
    init(dependencies: Container) {
        self.repository = dependencies.resolve(UserRepository.self)!
    }
    
    func load() {
        users = repository.fetch()
        reloadView()
    }
    
    func user(atIndex index: Int) -> User {
        return users[index]
    }
    
    private func reloadView() {
        users.isEmpty ? delegate?.showEmptyState() : delegate?.hideEmptyState()
    }
}

extension UserListViewModel: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UserTableViewCell.self)) as! UserTableViewCell
       
        let viewModel = UserCellViewModel(users[indexPath.row])
        cell.setup(viewModel)
        
        return cell
    }
}
