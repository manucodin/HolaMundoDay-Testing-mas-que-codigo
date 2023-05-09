//
//  UsersListViewController.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import UIKit

class UsersListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel: UserListViewModel
    
    init(viewModel: UserListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.load()
    }
    
    private func setupView() {
        configureNavigationBar()
        configureTableView()
    }
    
    private func configureNavigationBar() {
        title = "users".localized
        
        let createUserButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapCreate))
        createUserButton.accessibilityIdentifier = "btnCreateUser"
        
        navigationItem.rightBarButtonItems = [createUserButton]
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = viewModel
        tableView.accessibilityIdentifier = "usersList"
        
        let nibCell = UINib(nibName: String(describing: UserTableViewCell.self), bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: String(describing: UserTableViewCell.self))
    }

    @objc func didTapCreate() {
        let createUserViewController = CreateUserFactory.createUser()
        navigationController?.pushViewController(createUserViewController, animated: true)
    }
}

extension UsersListViewController: UserListDelegate {
    func showEmptyState() {
        tableView.backgroundView = UIView()
        tableView.reloadData()
    }
    
    func hideEmptyState() {
        tableView.backgroundView = nil
        tableView.reloadData()
    }
}

extension UsersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = viewModel.user(atIndex: indexPath.row)
        let editUserViewController = EditUserFactory.editUser(user: user)
        
        navigationController?.pushViewController(editUserViewController, animated: true)
    }
}
