//
//  ValidatorErrorTests.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 23/4/23.
//

import XCTest
import Nimble

@testable import HolaTesting

final class ValidatorErrorTests: XCTestCase {
    
    func testRequiredFieldMessage() {
        let sut = ValidationError.requiredField

        expect(sut.messageError).to(equal("required_field_error".localized))
    }
    
    func testInvalidFormat() {
        let sut = ValidationError.invalidFormat
        
        expect(sut.messageError).to(equal("format_field_error".localized))
    }
    
    func testInvalidLenght() {
        let sut = ValidationError.invalidLenght
        
        expect(sut.messageError).to(equal("lenght_field_error".localized))
    }
    
    func testErrorWithMessage() {
        let message = "test"
        let sut = ValidationError.error(message: message)
        
        expect(sut.messageError).to(equal("test"))
    }
}
