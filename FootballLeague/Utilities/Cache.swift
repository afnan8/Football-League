////
////  Cache.swift
////  FootballLeague
////
////  Created by Afnan on 11/6/20.
////
//
//import Foundation
//
//final class Cache<Key: Hashable, Value> {
//    
//    private let wrapped = NSCache<WrappedKey, Entry>()
//    private let dateProvider: () -> Date
//    private let entryLifetime: TimeInterval
//    private let keyTracker = KeyTracker()
//    
//    //    convenience init(from decoder: Decoder) throws {
//    //        self.init()
//    //
//    //        let container = try decoder.singleValueContainer()
//    //        let entries = try container.decode([Entry].self)
//    //        entries.forEach(insert)
//    //    }
//    
//    init(dateProvider: @escaping () -> Date = Date.init,
//         entryLifetime: TimeInterval = 12 * 60 * 60,
//         maximumEntryCount: Int = 50) {
//        self.dateProvider = dateProvider
//        self.entryLifetime = entryLifetime
//        wrapped.countLimit = maximumEntryCount
//        wrapped.delegate = keyTracker
//    }
//    
//    func insert(_ value: Value, forKey key: Key) {
//        let date = dateProvider().addingTimeInterval(entryLifetime)
//        let entry = Entry(key: key, value: value, expirationDate: date)
//        wrapped.setObject(entry, forKey: WrappedKey(key))
//        keyTracker.keys.insert(key)
//        insert(entry)
//    }
//    
//    func value(forKey key: Key) -> Value? {
//        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
//            return nil
//        }
//        
//        guard dateProvider() < entry.expirationDate else {
//            // Discard values that have expired
//            removeValue(forKey: key)
//            return nil
//        }
//        
//        return entry.value
//    }
//    
//    func removeValue(forKey key: Key) {
//        wrapped.removeObject(forKey: WrappedKey(key))
//    }
//}
//
//private extension Cache {
//    final class WrappedKey: NSObject { // wrap Key values in order to make them NSCache compatible. 
//        let key: Key
//        
//        init(_ key: Key) { self.key = key }
//        
//        override var hash: Int { return key.hashValue }
//        
//        override func isEqual(_ object: Any?) -> Bool {
//            guard let value = object as? WrappedKey else {
//                return false
//            }
//            
//            return value.key == key
//        }
//    }
//}
//
//private extension Cache {
//    
//    final class Entry { //allow cache to store a Value
//        let key: Key
//        let value: Value
//        let expirationDate: Date
//        
//        init(key: Key, value: Value, expirationDate: Date) {
//            self.key = key
//            self.value = value
//            self.expirationDate = expirationDate
//        }
//    }
//}
//
//extension Cache {
//    subscript(key: Key) -> Value? { //  retrieve and insert values
//        get { return value(forKey: key) }
//        set {
//            guard let value = newValue else {
//                // If nil was assigned using our subscript,
//                // then we remove any value for that key:
//                removeValue(forKey: key)
//                return
//            }
//            
//            insert(value, forKey: key)
//        }
//    }
//}
//
//private extension Cache {
//    final class KeyTracker: NSObject, NSCacheDelegate {
//        var keys = Set<Key>()
//        
//        func cache(_ cache: NSCache<AnyObject, AnyObject>,
//                   willEvictObject object: Any) {
//            guard let entry = object as? Entry else {
//                return
//            }
//            
//            keys.remove(entry.key)
//        }
//    }
//}
//
////extension Cache.Entry: Codable where Key: Codable, Value: Codable {}
//
//private extension Cache {
//    func entry(forKey key: Key) -> Entry? {
//        guard let entry = wrapped.object(forKey: WrappedKey(key)) else {
//            return nil
//        }
//
//        guard dateProvider() < entry.expirationDate else {
//            removeValue(forKey: key)
//            return nil
//        }
//
//        return entry
//    }
//
//    func insert(_ entry: Entry) {
//        wrapped.setObject(entry, forKey: WrappedKey(entry.key))
//        keyTracker.keys.insert(entry.key)
//    }
//}
////
////extension Cache {
////    convenience init(from dictionary: [String: Any]) throws {
////        self.init()
////
//////        let container = try decoder.singleValueContainer()
//////        let entries = try container.decode([Entry].self)
////        entries.forEach(insert)
////    }
////
////    func encode(to encoder: Encoder) throws {
////        var container = encoder.singleValueContainer()
////        try container.encode(keyTracker.keys.compactMap(entry))
////    }
////}
//
//extension Cache {
//    func saveToDisk(
//        withName name: String,
//        using fileManager: FileManager = .default
//    ) throws {
//        let folderURLs = fileManager.urls(
//            for: .cachesDirectory,
//            in: .userDomainMask
//        )
//
//        let fileURL = folderURLs[0].appendingPathComponent(name + ".cache")
//        let data = try JSONEncoder().encode(self)
//        try data.write(to: fileURL)
//    }
//}
