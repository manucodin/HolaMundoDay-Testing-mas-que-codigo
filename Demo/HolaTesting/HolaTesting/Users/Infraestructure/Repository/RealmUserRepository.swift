//
//  RealmUserRepository.swift
//  HolaTesting
//
//  Created by Manuel Rodriguez Sebastian on 22/4/23.
//

import Foundation
import RealmSwift

class RealmUserRepository {
    
    private let realm: Realm
    private let configuration = Realm.Configuration(schemaVersion: 1)
    
    init() {
        self.realm = try! Realm(configuration: configuration)
    }
}

extension RealmUserRepository: UserRepository {
    func add(_ user: User) throws {
        do {
            try realm.write {
                realm.add(UserEntity(user))
            }
        } catch {
            throw RepositoryError.unexpected
        }
    }
    
    func fetch() -> [User] {
        return realm.objects(UserEntity.self).map({ User($0) })
    }
    
    func update(_ user: User) throws {
        do {
            try realm.write {
                realm.add(UserEntity(user), update: .modified)
            }
        } catch {
            throw RepositoryError.unexpected
        }
    }
    
    func delete(_ user: User) throws {
        guard let userEntity = realm.object(ofType: UserEntity.self, forPrimaryKey: user.id) else {
            throw RepositoryError.unexpected
        }
        
        do {
            try realm.write {
                realm.delete(userEntity)
            }
        } catch {
            throw RepositoryError.unexpected
        }
    }
}
