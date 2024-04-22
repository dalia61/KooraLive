//
//  RealmManager.swift
//  KooraLive
//
//  Created by Dalia on 22/04/2024.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    private let realm: Realm
    
    private init() {
        realm = try! Realm()
    }
    
    func retrieveAllDataForObject<T: Object>(_ objectType: T.Type) -> [T] {
        return Array(realm.objects(objectType))
    }
    
    func deleteAllDataForObject<T: Object>(_ objectType: T.Type) {
        let objects = retrieveAllDataForObject(objectType)
        delete(objects)
    }
    
    func replaceAllDataForObject<T: Object>(_ objectType: T.Type, with objects: [T]) {
        deleteAllDataForObject(objectType)
        add(objects)
    }
    
    func add<T: Object>(_ objects: [T]) {
        do {
            try realm.write {
                realm.add(objects)
            }
        } catch {
            print("Error adding objects to Realm: \(error)")
        }
    }
    
    func add<T: Object>(_ object: T) {
        add([object])
    }
    
    func update(_ block: @escaping () -> Void) {
        do {
            try realm.write {
                block()
            }
        } catch {
            print("Error updating Realm: \(error)")
        }
    }
    
    func delete(_ objects: [Object]) {
        do {
            try realm.write {
                realm.delete(objects)
            }
        } catch {
            print("Error deleting objects from Realm: \(error)")
        }
    }
    
    func delete<T: Object>(_ objectType: T.Type, with predicate: NSPredicate) {
        let objects = realm.objects(objectType).filter(predicate)
        delete(Array(objects))
    }
    
    func getRealmFileURL() -> String? {
        return realm.configuration.fileURL?.path
    }
}
