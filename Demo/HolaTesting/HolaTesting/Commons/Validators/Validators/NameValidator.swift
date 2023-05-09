//
//  NameValidator.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import Foundation

class NameValidator: Validator {
    func validate(_ value: Any?) -> ValidationError? {
        guard let value = value as? String else { return .invalidFormat }
        guard checkNamePattern(value) else { return .invalidFormat }

        if value.isEmpty {
            return .requiredField
        }
        
        if value.count <= 2 {
            return .invalidLenght
        }
        
        return nil
    }
    
    private func checkNamePattern(_ value: String) -> Bool {
        let phonePattern = #"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$"#
        let result = value.range(of: phonePattern, options: .regularExpression)

        return result != nil
    }
}
