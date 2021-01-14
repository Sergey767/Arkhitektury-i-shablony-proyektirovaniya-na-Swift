//
//  RealmProvider.swift
//  Vkontakte
//
//  Created by Сергей Горячев on 04.04.2020.
//  Copyright © 2020 appleS. All rights reserved.
//

import Foundation
import RealmSwift

class RealmProvider: Operation {
    
    static let instance = RealmProvider()
    override init(){}
    
    static let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
    
    static func save<T: Object>(items: [T],
        configuration: Realm.Configuration = deleteIfMigration,
        update: Realm.UpdatePolicy = .modified) throws {
        let realm = try Realm(configuration: configuration)
        print(configuration.fileURL ?? "")
        try realm.write {
            realm.add(items, update: update)
        }
    }
    
    func saveItems<Element: Object>(items: [Element], needMigrate: Bool = false, needUpdate: Bool = true) -> Realm? {
        
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: needMigrate)
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(items, update: .all)
            }
            return realm
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    static func get<T: Object>(_ type: T.Type, configuration: Realm.Configuration = deleteIfMigration) throws -> Results<T> {
        print(configuration.fileURL ?? "")
        let realm = try Realm(configuration: configuration)
        return realm.objects(type)
    }
    
    func getItems<T: Object>(_ type: T.Type, in realm: Realm? = try? Realm(configuration: RealmProvider.deleteIfMigration)) -> Results<T>? {
        return realm?.objects(type)
    }
    
    func getMyGroups() -> [Group] {
        var myGroups = [Group]()
        do {
            let realm = try Realm()
            let groups = realm.objects(Group.self)
            for group in groups {
                myGroups.append(group)
            }
        } catch {
            print("Realm getMyFriends error: \(error)")
        }
        return myGroups
    }
    
    func getMyFriends() -> [User] {
        var myFriends = [User]()
        do {
            let realm = try Realm()
            let friends = realm.objects(User.self)
            for friend in friends {
                myFriends.append(friend)
            }
        } catch {
            print("Realm getMyFriends error: \(error)")
        }
        return myFriends
    }
}
