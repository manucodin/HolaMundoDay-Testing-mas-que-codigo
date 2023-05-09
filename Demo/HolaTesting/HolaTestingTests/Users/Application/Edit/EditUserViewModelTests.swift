//
//  EditUserViewModelTests.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 1/5/23.
//

import XCTest
import Nimble
import Swinject

@testable import HolaTesting

final class EditUserViewModelTests: XCTestCase {

    private var sut: EditUserViewModel!
    private var repositoryMock: RealmUserRepositoryMock!
    private var editDelegateMock: EditUserDelegateMock!
    private var deleteDelegateMock: DeleteUserDelegateMock!
    
    override func setUp() {
        super.setUp()
        
        repositoryMock = RealmUserRepositoryMock()
        editDelegateMock = EditUserDelegateMock()
        deleteDelegateMock = DeleteUserDelegateMock()
        
        let dependencies = Container()
        dependencies.register(UserRepository.self) { _ in self.repositoryMock }
        dependencies.register(NameValidator.self) { _ in NameValidator() }
        dependencies.register(PhoneValidator.self) { _ in PhoneValidator() }
        dependencies.register(EmailValidator.self) { _ in EmailValidator() }
        
        let user = User(
            name: "Juan",
            lastName: "Garcia",
            phoneNumber: "666777888",
            email: "juan@juan.com",
            address: "Calle 1"
        )

        sut = EditUserViewModel(user: user, dependencies: dependencies)
        sut.editDelegate = editDelegateMock
        sut.deleteDelegate = deleteDelegateMock
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
    }
    
    func testUpdateName() {
        sut.update(name: "Juan Luis")
        
        expect(self.editDelegateMock.invokedEnableSave).to(beTrue())
        expect(self.editDelegateMock.invokedEnableSaveParameters?.enabled).to(beTrue())
    }
    
    func testUpdateLastName() {
        sut.update(lastName: "Hernandez")
        
        expect(self.editDelegateMock.invokedEnableSave).to(beTrue())
        expect(self.editDelegateMock.invokedEnableSaveParameters?.enabled).to(beTrue())
    }
    
    func testUpdatePhone() {
        sut.update(phoneNumber: "777888999")
        
        expect(self.editDelegateMock.invokedEnableSave).to(beTrue())
        expect(self.editDelegateMock.invokedEnableSaveParameters?.enabled).to(beTrue())
    }
    
//    func testUpdateEmail() {
//        sut.update(email: "juanluis@juan.com")
//        
//        expect(self.editDelegateMock.invokedEnableSave).to(beTrue())
//        expect(self.editDelegateMock.invokedEnableSaveParameters?.enabled).to(beTrue())
//    }
    
    func testUpdateAddress() {
        sut.update(address: "Calle 2")
        
        expect(self.editDelegateMock.invokedEnableSave).to(beTrue())
        expect(self.editDelegateMock.invokedEnableSaveParameters?.enabled).to(beTrue())
    }
    
    func testUpdateUser() {
        sut.update(name: "Juan Luis")
        sut.update(email: "juan2@juan.com")

        sut.didTapUpdate()

        expect(self.editDelegateMock.invokedEnableSave).to(beTrue())
        expect(self.editDelegateMock.invokedEnableSaveParameters?.enabled).to(beTrue())
        expect(self.repositoryMock.invokedUpdate).to(beTrue())
        expect(self.editDelegateMock.invokedSuccessEdit).to(beTrue())
    }

    func testUpdateUserWithErrors() {
        sut.update(name: "juan@juan.com")
        sut.update(email: "666777888")

        sut.didTapUpdate()

        expect(self.editDelegateMock.invokedEnableSave).to(beTrue())
        expect(self.editDelegateMock.invokedEnableSaveParameters?.enabled).to(beTrue())
        expect(self.repositoryMock.invokedUpdate).to(beFalse())
        expect(self.editDelegateMock.invokedShowUpdateError).to(beTrue())
    }
    
    func testDeleteUser() {
        sut.didTapDelete()
    }
    
    func testDeleteUserWithErrors() {
        
    }
}
