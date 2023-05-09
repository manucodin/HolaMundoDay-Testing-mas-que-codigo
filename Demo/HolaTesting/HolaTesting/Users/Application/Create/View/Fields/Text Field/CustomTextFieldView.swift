//
//  CustomTextFieldView.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import UIKit

class CustomTextFieldView: UIView, CustomViewProtocol {
    
    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!

    var didChange: ((String) -> Void)?
    
    var drawer: CustomTextFieldDrawer? {
        didSet {
            guard let drawer else { return }
            
            configure(drawer)
        }
    }
    var value: String {
        return textField.text ?? ""
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit(for: String(describing: CustomTextFieldView.self))
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit(for: String(describing: CustomTextFieldView.self))
    }
    
    private func configure(_ drawer: CustomTextFieldDrawer) {
        titleLabel.text = drawer.title
        textField.placeholder = drawer.placeholder
        textField.text = drawer.text
        textField.keyboardType = drawer.keyboardType
        textField.textContentType = drawer.textContentType
        textField.accessibilityIdentifier = drawer.accessibilityIdentifier
        textField.addTarget(self, action: #selector(didChangeTextField), for: .editingChanged)
    }
    
    @objc func didChangeTextField(_ sender: UITextField) {
        didChange?(textField.text ?? "")
    }
}
