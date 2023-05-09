//
//  PhoneValidator.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import Foundation

class PhoneValidator: Validator {
    func validate(_ value: Any?) -> ValidationError? {
        guard let value = value as? String else { return .invalidFormat }
//        guard checkPhonePattern(value) else { return .invalidFormat }
        
        if value.isEmpty {
            return .requiredField
        }
        
        if value.count < 6 {
            return .invalidLenght
        }
        
        return nil
    }
    
    private func checkPhonePattern(_ value: String) -> Bool {
        let phonePattern = #"^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$|(\d{9})$"#
        let result = value.range(of: phonePattern, options: .regularExpression)

        return result != nil
    }
}
