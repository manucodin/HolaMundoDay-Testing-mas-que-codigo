//
//  NameValidatorTests.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 23/4/23.
//

import XCTest
import Nimble

@testable import HolaTesting

final class NameValidatorTests: XCTestCase {

    private var sut: Validator!
    
    override func setUp() {
        super.setUp()
        
        sut = NameValidator()
    }
    
    override func tearDown() {
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
        let error = sut.validate("a")
        
        expect(error).toNot(beNil())
    }
    
    func testValidateShortNameTwoCharacter() {
        let error = sut.validate("ab")
            
        expect(error).toNot(beNil())
    }
    
    func testValidateNormalName() {
        let error = sut.validate("abc")
        
        expect(error).to(beNil())
    }
    
    func testValidateInvalidName() {
        let error = sut.validate("677864??--")
        
        expect(error).toNot(beNil())
    }
}
