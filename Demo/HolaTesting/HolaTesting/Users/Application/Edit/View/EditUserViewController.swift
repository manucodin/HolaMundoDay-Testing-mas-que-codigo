//
//  EditUserViewController.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import UIKit

class EditUserViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var nameField: CustomTextFieldView!
    @IBOutlet weak var seconNameField: CustomTextFieldView!
    @IBOutlet weak var phoneField: CustomTextFieldView!
    @IBOutlet weak var emailField: CustomTextFieldView!
    @IBOutlet weak var addressField: CustomTextFieldView!
    @IBOutlet weak var deleteButton: UIButton! {
        didSet {
            deleteButton.setTitle("delete".localized, for: .normal)
            deleteButton.tintColor = .red
        }
    }
    
    private let viewModel: EditUserViewModel
    
    init(viewModel: EditUserViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel.editDelegate = self
        viewModel.deleteDelegate = self
    }
    
    private func setupView() {
        configureNavigationBar()
        configureFields()
    }
    
    private func configureNavigationBar() {
        title = "new_user".localized
        
        let createUserButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapUpdate))
        createUserButton.isEnabled = false
        navigationItem.rightBarButtonItems = [createUserButton]
    }
    
    @objc func didTapUpdate() {
        viewModel.didTapUpdate()
    }
    
    
    @IBAction func didTapDelete(_ sender: Any) {
        viewModel.didTapDelete()
    }
    
    private func configureFields() {
        configureNameField()
        configureSeconNameField()
        configurePhoneField()
        configureAddressField()
        configureEmailField()
    }
    
    private func configureNameField() {
        nameField.drawer = CustomTextFieldDrawer(
            title: "\("name".localized)*",
            text: viewModel.name,
            placeholder: "name".localized,
            keyboardType: .default,
            textContentType: .name
        )
        nameField.didChange = { self.viewModel.update(name: $0) }
    }
    
    private func configureSeconNameField() {
        seconNameField.drawer = CustomTextFieldDrawer(
            title: "\("lastName".localized)*",
            text: viewModel.lastName,
            placeholder: "lastName".localized,
            keyboardType: .default,
            textContentType: .name
        )
        seconNameField.didChange = { self.viewModel.update(lastName: $0) }
    }
    
    private func configurePhoneField() {
        phoneField.drawer = CustomTextFieldDrawer(
            title: "\("phoneNumber".localized)*",
            text: viewModel.phoneNumber,
            placeholder: "phoneNumber".localized,
            keyboardType: .namePhonePad,
            textContentType: .telephoneNumber
        )
        phoneField.didChange = { self.viewModel.update(phoneNumber: $0) }
    }
    
    private func configureEmailField() {
        emailField.drawer = CustomTextFieldDrawer(
            title: "\("email".localized)*",
            text: viewModel.email,
            placeholder: "email".localized,
            keyboardType: .namePhonePad,
            textContentType: .emailAddress
        )
        emailField.didChange = { self.viewModel.update(email: $0) }
    }
    
    private func configureAddressField() {
        addressField.drawer = CustomTextFieldDrawer(
            title: "address".localized,
            text: viewModel.address,
            placeholder: "address".localized,
            keyboardType: .default,
            textContentType: .addressCity
        )
        addressField.didChange = { self.viewModel.update(address: $0) }
    }
}

extension EditUserViewController: EditUserDelegate {
    func enableSave(enabled: Bool) {
        navigationItem.rightBarButtonItems?.first?.isEnabled = enabled
    }
    
    func successEdit(message: String) {
        let alertController = UIAlertController(
            title: "success".localized,
            message: message,
            preferredStyle: .alert
        )
        
        let acceptAction = UIAlertAction(title: "accept".localized, style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(acceptAction)
        
        navigationController?.present(alertController, animated: true)
    }
    
    func showUpdateError(errorMessage: String) {
        let alertController = UIAlertController(
            title: "error".localized,
            message: errorMessage,
            preferredStyle: .alert
        )
        
        let defaultAction = UIAlertAction(title: "accept".localized, style: .default)
        alertController.addAction(defaultAction)
        
        navigationController?.present(alertController, animated: true)
    }
}

extension EditUserViewController: DeleteUserDelegate {
    func successDelete(message: String) {
        let alertController = UIAlertController(
            title: "success".localized,
            message: message,
            preferredStyle: .alert
        )
        
        let acceptAction = UIAlertAction(title: "accept".localized, style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(acceptAction)
        
        navigationController?.present(alertController, animated: true)
    }
    
    func showDeleteError(errorMessage: String) {
        let alertController = UIAlertController(
            title: "error".localized,
            message: errorMessage,
            preferredStyle: .alert
        )
        
        let defaultAction = UIAlertAction(title: "accept".localized, style: .default)
        alertController.addAction(defaultAction)
        
        navigationController?.present(alertController, animated: true)
    }
}
