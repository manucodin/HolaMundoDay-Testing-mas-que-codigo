//
//  UserCellViewModelTests.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 23/4/23.
//

import XCTest
import Nimble

@testable import HolaTesting

final class UserCellViewModelTests: XCTestCase {
        
    func testMainText() {
        let user = User(
            name: "Juan",
            lastName: "Garcia",
            phoneNumber: "666777888"
        )
        let sut = UserCellViewModel(user)
        
        let expectedText = "\(user.name) \(user.lastName)"
        
        expect(sut.mainText).to(equal(expectedText))
    }
    
    func testSecondaryText() {
        let user = User(
            name: "Juan",
            lastName: "Garcia",
            phoneNumber: "666777888"
        )
        let sut = UserCellViewModel(user)
        
        let expectedText = String(format: "phone_formated".localized, "\(user.phoneNumber)")
        
        expect(sut.secondaryText).to(equal(expectedText))
    }
}
