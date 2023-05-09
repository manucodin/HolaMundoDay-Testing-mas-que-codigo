//
//  UserEntityTests.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 23/4/23.
//

import XCTest
import Nimble

@testable import HolaTesting

final class UserEntityTests: XCTestCase {
    
    func testDefaultInit() {
        let name = "Juan"
        let lastName = "Garcia"
        let phoneNumber = "666777888"
        let email = "juan@juan.com"
        let address = "Calle 1"
        
        let sut = UserEntity(name: name, lastName: lastName, phoneNumber: phoneNumber, email: email, address: address)
        
        expect(sut.name).to(equal(name))
        expect(sut.lastName).to(equal(lastName))
        expect(sut.phoneNumber).to(equal(phoneNumber))
        expect(sut.address).to(equal(address))
//        expect(sut.email).to(equal(email))
    }
    
    func testInitWithEntity() {
        let name = "Juan"
        let lastName = "Garcia"
        let phoneNumber = "666777888"
        let email = "juan@juan.com"
        let address = "Calle 1"
        
        let user = User(name: name, lastName: lastName, phoneNumber: phoneNumber, email: email, address: address)
        let sut = UserEntity(user)
        
        expect(sut.name).to(equal(user.name))
        expect(sut.lastName).to(equal(user.lastName))
        expect(sut.phoneNumber).to(equal(user.phoneNumber))
        expect(sut.address).to(equal(user.address))
//        expect(sut.email).to(equal(user.email))
    }
}
