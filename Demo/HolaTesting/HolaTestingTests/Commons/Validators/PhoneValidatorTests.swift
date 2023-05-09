//
//  PhoneValidatorTests.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 23/4/23.
//

import XCTest
import Nimble

@testable import HolaTesting

final class PhoneValidatorTests: XCTestCase {

    private var sut: Validator!
    
    override func setUp() {
        super.setUp()
        
        sut = PhoneValidator()
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }

    func testValidateNilValue() {
        let error = sut.validate(nil)
        
        expect(error).toNot(beNil())
    }
    
    func testValidateEmptyName() {
        let error = sut.validate("")
        
        expect(error).toNot(beNil())
    }
    
    func testValidateShortNameOneCharacter() {
        let error = sut.validate("12345")
        
        expect(error).toNot(beNil())
    }
    
    func testValidateNormalPhone() {
        let error = sut.validate("666777888")
        
        expect(error).to(beNil())
    }
    
//    func testValidateNotNumber() {
//        let error = sut.validate("123fdsfdfsiu--?")
//
//        expect(error).toNot(beNil())
//    }
}
