//
//  UserListViewModelTests.swift
//  HolaTestingTests
//
//  Created by Manuel Rodriguez Sebastian on 23/4/23.
//

import XCTest
import Nimble
import Swinject

@testable import HolaTesting

final class UserListViewModelTests: XCTestCase {
    
    private var sut: UserListViewModel!
    private var repositoryMock: RealmUserRepositoryMock!
    private var delegateMock: UserListDelegateMock!
    
    override func setUp() {
        super.setUp()
        
        repositoryMock = RealmUserRepositoryMock()
        delegateMock = UserListDelegateMock()
        
        let dependencies = Container()
        dependencies.register(UserRepository.self) { _ in self.repositoryMock }
        
        sut = UserListViewModel(dependencies: dependencies)
        sut.delegate = delegateMock
    }
    
    override func tearDown() {
        super.tearDown()
        
        sut = nil
        repositoryMock = nil
        delegateMock = nil
    }
    
    func testLoadUsersList() {
        let users = [
            User(name: "Juan", lastName: "Garcia", phoneNumber: "666777888"),
            User(name: "Luis", lastName: "Hernandez", phoneNumber: "777666888")
        ]
        repositoryMock.stubbedFetchResult = users

        sut.load()
        
        expect(self.sut.isEmpty).to(beFalse())
        expect(self.delegateMock.invokedHideEmptyState).to(beTrue())
    }
    
    func testLoadEmptyUsersList() {
        repositoryMock.stubbedFetchResult = []
        
        sut.load()
        
        expect(self.sut.isEmpty).to(beTrue())
        expect(self.delegateMock.invokedShowEmptyState).to(beTrue())
    }
}
