//
//  RealmManager.swift
//  FootballLeague
//
//  Created by Afnan on 11/6/20.
//

import RealmSwift

class RealmManager {
    
    static let instance = RealmManager()
    
    var realm: Realm!
    
    private init() {
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                }
            })
        
        // Tell Realm to use this new configuration object for the default Realm
        Realm.Configuration.defaultConfiguration = config
        
    }
    
    func initializeRealmObject() {
        do {
            let realm = try Realm()
            self.realm = realm
        } catch let error as NSError {
            print(error)
        }
    }
    
    func saveObjects(_ objects: [Object]) {
        if realm == nil {
            initializeRealmObject()
            saveObjects(objects)
        } else {
            do {
                try realm.write {
                    realm.add(objects, update: .all)
                }
            } catch let error as NSError {
                print(error)
            }
        }
    }
    
    func getAllSavedObjects<T: Object>(_ t: T) -> [T] {
        if realm == nil {
            initializeRealmObject()
            return getAllSavedObjects(t)
        } else {
            let realmResults = realm.objects(T.self)
            return Array(realmResults)
            
        }
    }
}

public protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    init(managedObject: ManagedObject)
    func managedObject() -> ManagedObject
}
