//
//  RepositoryError.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import Foundation

enum RepositoryError: Error {
    case error(message: String)
    case unexpected
    
    var messageError: String {
        switch self {
        case .error(let message): return message
        case .unexpected: return "unexpected_error".localized
        }
    }
}
