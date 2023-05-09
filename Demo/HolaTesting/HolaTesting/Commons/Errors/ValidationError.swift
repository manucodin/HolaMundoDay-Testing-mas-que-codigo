//
//  ValidationError.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import Foundation

enum ValidationError: Error {
    case requiredField
    case invalidFormat
    case invalidLenght
    case error(message: String)
    
    var messageError: String {
        switch self {
        case .requiredField: return "required_field_error".localized
        case .invalidFormat: return "format_field_error".localized
        case .invalidLenght: return "lenght_field_error".localized
        case .error(let message): return message
        }
    }
}
