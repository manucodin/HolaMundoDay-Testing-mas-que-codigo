//
//  Validator.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import Foundation

protocol Validator {
    func validate(_ value: Any?) -> ValidationError?
}
