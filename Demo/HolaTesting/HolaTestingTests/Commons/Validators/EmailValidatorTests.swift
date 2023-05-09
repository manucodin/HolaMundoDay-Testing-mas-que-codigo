//
//  EmailValidator.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 1/5/23.
//

import XCTest
import Nimble

@testable import HolaTesting

final class EmailValidatorTests: XCTestCase {
    
    private var sut: Validator!
    
    override func setUp() {
        super.setUp()
        
        sut = EmailValidator()
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testValidateNilValue() {
        let error = sut.validate(nil)
        
        expect(error).toNot(beNil())
    }
    
    func testValidateEmptyValue() {
        let error = sut.validate("")
        
        expect(error).toNot(beNil())
    }
    
    func testValidateNotEmailValue() {
        let error = sut.validate("test")
        
        expect(error).toNot(beNil())
    }
    
    func testValidateEmail() {
        let error = sut.validate("juan@juan.com")
        
        expect(error).to(beNil())
    }
}
