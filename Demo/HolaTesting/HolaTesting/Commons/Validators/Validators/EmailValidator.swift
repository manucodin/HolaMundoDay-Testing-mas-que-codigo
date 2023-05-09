//
//  EmailValidator.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 1/5/23.
//

import Foundation

class EmailValidator: Validator {
    func validate(_ value: Any?) -> ValidationError? {
        guard let value = value as? String else { return .invalidFormat }
        guard checkEmailPattern(value) else { return .invalidFormat }
        
        if value.isEmpty {
            return .requiredField
        }
        
        return nil
    }
    
    private func checkEmailPattern(_ value: String) -> Bool {
        let emailPattern = #"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$"#
        let result = value.range(of: emailPattern, options: .regularExpression)
        
        return result != nil
    }
}
