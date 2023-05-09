//
//  CreateUserViewController.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import UIKit

class CreateUserViewController: UIViewController {
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var nameField: CustomTextFieldView!
    @IBOutlet weak var seconNameField: CustomTextFieldView!
    @IBOutlet weak var phoneField: CustomTextFieldView!
    @IBOutlet weak var emailField: CustomTextFieldView!
    @IBOutlet weak var addressField: CustomTextFieldView!
    
    private let viewModel: CreateUserViewModel
    
    init(viewModel: CreateUserViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        viewModel.delegate = self
    }
    
    private func setupView() {
        configureNavigationBar()
        configureFields()
    }
    
    private func configureNavigationBar() {
        title = "new_user".localized
        
        let createUserButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapSave))
        createUserButton.isEnabled = false
        createUserButton.accessibilityIdentifier = "btnSaveUser"

        navigationItem.rightBarButtonItems = [createUserButton]
    }
    
    @objc func didTapSave() {
        viewModel.didTapSave()
    }
    
    private func configureFields() {
        configureNameField()
        configureLastNameField()
        configurePhoneField()
        configureAddressField()
        configureEmailField()
    }
    
    private func configureNameField() {
        nameField.drawer = CustomTextFieldDrawer(
            title: "\("name".localized)*",
            placeholder: "name".localized,
            keyboardType: .default,
            textContentType: .name,
            accessibilityIdentifier: "textFieldName"
        )
        nameField.didChange = { self.viewModel.update(name: $0) }
    }
    
    private func configureLastNameField() {
        seconNameField.drawer = CustomTextFieldDrawer(
            title: "\("lastName".localized)*",
            placeholder: "lastName".localized,
            keyboardType: .default,
            textContentType: .name,
            accessibilityIdentifier: "textFieldLastName"
        )
        seconNameField.didChange = { self.viewModel.update(lastName: $0) }
    }
    
    private func configurePhoneField() {
        phoneField.drawer = CustomTextFieldDrawer(
            title: "\("phoneNumber".localized)*",
            placeholder: "phoneNumber".localized,
            keyboardType: .namePhonePad,
            textContentType: .telephoneNumber,
            accessibilityIdentifier: "textFieldPhone"
        )
        phoneField.didChange = { self.viewModel.update(phoneNumber: $0) }
    }
    
    private func configureEmailField() {
        emailField.drawer = CustomTextFieldDrawer(
            title: "\("email".localized)*",
            placeholder: "email".localized,
            keyboardType: .namePhonePad,
            textContentType: .emailAddress,
            accessibilityIdentifier: "textFieldEmail"
        )
        emailField.didChange = { self.viewModel.update(email: $0) }
    }
    
    private func configureAddressField() {
        addressField.drawer = CustomTextFieldDrawer(
            title: "address".localized,
            placeholder: "address".localized,
            keyboardType: .default,
            textContentType: .addressCity,
            accessibilityIdentifier: "textFieldAddress"
        )
        addressField.didChange = { self.viewModel.update(address: $0) }
    }
}

extension CreateUserViewController: CreateUserDelegate {    
    func enableCreate(enabled: Bool) {
        navigationItem.rightBarButtonItems?.first?.isEnabled = enabled
    }
    
    func successCreate(message: String) {
        let alertController = UIAlertController(
            title: "success".localized,
            message: message,
            preferredStyle: .alert
        )
        alertController.view.accessibilityIdentifier = "alert"
        
        let acceptAction = UIAlertAction(title: "accept".localized, style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        acceptAction.accessibilityIdentifier = "alertBtnAccept"
        alertController.addAction(acceptAction)
        
        navigationController?.present(alertController, animated: true)
    }
    
    func showCreateError(errorMessage: String) {
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
