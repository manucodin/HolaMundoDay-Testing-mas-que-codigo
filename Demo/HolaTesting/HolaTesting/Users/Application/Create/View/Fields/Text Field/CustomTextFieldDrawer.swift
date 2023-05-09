//
//  CustomTextFieldDrawer.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import UIKit

struct CustomTextFieldDrawer {
    let title: String
    let text: String?
    let placeholder: String
    let keyboardType: UIKeyboardType
    let textContentType: UITextContentType?
    let accessibilityIdentifier: String?
    
    init(title: String, text: String? = nil, placeholder: String, keyboardType: UIKeyboardType = .default, textContentType: UITextContentType? = nil, accessibilityIdentifier: String? = nil) {
        self.title = title
        self.text = text
        self.placeholder = placeholder
        self.keyboardType = keyboardType
        self.textContentType = textContentType
        self.accessibilityIdentifier = accessibilityIdentifier
    }
}
