//
//  CreateUserViewModelTests.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 23/4/23.
//

import XCTest
import Nimble
import Swinject

@testable import HolaTesting

final class CreateUserViewModelTests: XCTestCase {

    private var sut: CreateUserViewModel!
    private var repositoryMock: RealmUserRepositoryMock!
    private var delegateMock: CreateUserDelegateMock!
        
    override func setUp() {
        super.setUp()
        
        repositoryMock = RealmUserRepositoryMock()
        delegateMock = CreateUserDelegateMock()

        let dependencies = Container()
        dependencies.register(UserRepository.self) { _ in self.repositoryMock }
        dependencies.register(NameValidator.self) { _ in NameValidator() }
        dependencies.register(PhoneValidator.self) { _ in PhoneValidator() }
        dependencies.register(EmailValidator.self) { _ in EmailValidator() }
        
        sut = CreateUserViewModel(dependencies: dependencies)
        sut.delegate = delegateMock
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
        repositoryMock = nil
        delegateMock = nil
    }
    
    func testUpdateName() {
        let name = "Juan"
        sut.update(name: name)
        
        expect(self.sut.user.name).to(equal(name))
        expect(self.sut.isNameFilled).to(beTrue())
        expect(self.sut.isRequiredFieldsFilled).to(beFalse())
    }

    func testUpdateLastName() {
        let lastName = "Garcia"
        sut.update(lastName: lastName)
        
        expect(self.sut.user.lastName).to(equal(lastName))
        expect(self.sut.isLastNameFilled).to(beTrue())
        expect(self.sut.isRequiredFieldsFilled).to(beFalse())
    }
    
    func testUpdatePhone() {
        let phoneNumber = "666777888"
        sut.update(phoneNumber: phoneNumber)
        
        expect(self.sut.user.phoneNumber).to(equal(phoneNumber))
        expect(self.sut.isPhoneNumberFilled).to(beTrue())
        expect(self.sut.isRequiredFieldsFilled).to(beFalse())
    }
    
//    func testUpdateEmail() {
//        let email = "juan@juan.com"
//
//        sut.update(email: email)
//
//        expect(self.sut.user.email).to(equal(email))
//        expect(self.sut.isEmailFilled).to(beTrue())
//    }
    
    func testUpdateAddress() {
        let address = "Calle 1"
        
        sut.update(address: address)
        
        expect(self.sut.user.address).to(equal(address))
    }
    
    func testUpdateAllRequiredFields() {
        let name = "Juan"
        let lastName = "Garcia"
        let phoneNumber = "666777888"
//        let email = "juan@juan.com"

        sut.update(name: name)
        sut.update(lastName: lastName)
        sut.update(phoneNumber: phoneNumber)
//        sut.update(email: email)
        
        expect(self.sut.isRequiredFieldsFilled).to(beTrue())
    }
    
    func testSaveUserWithErrors() {
        sut.didTapSave()
        
        expect(self.delegateMock.invokedShowCreateError).to(beTrue())
        expect(self.delegateMock.invokedShowCreateErrorCount).to(equal(1))
        expect(self.repositoryMock.invokedAdd).to(beFalse())
    }
    
    func testSaveUserWithoutErrors() {
        let name = "Juan"
        let lastName = "Garcia"
        let phoneNumber = "666777888"
//        let email = "juan@juan.com"
        
        sut.update(name: name)
        sut.update(lastName: lastName)
        sut.update(phoneNumber: phoneNumber)
//        sut.update(email: email)
        
        sut.didTapSave()
        
        expect(self.sut.isRequiredFieldsFilled).to(beTrue())
        expect(self.delegateMock.invokedShowCreateError).to(beFalse())
        expect(self.repositoryMock.invokedAdd).to(beTrue())
        expect(self.delegateMock.invokedSuccessCreate).to(beTrue())
    }
}
