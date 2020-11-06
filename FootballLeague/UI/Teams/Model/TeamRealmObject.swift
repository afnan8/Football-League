//
//  TeamRealmObject.swift
//  FootballLeague
//
//  Created by Afnan on 11/6/20.
//

import RealmSwift

final class TeamObject: Object {
    
    @objc dynamic var address: String! = ""
    @objc dynamic var area: AreaObject? = AreaObject()
    @objc dynamic var clubColors: String! = ""
    @objc dynamic var crestUrl: String! = ""
    @objc dynamic var email: String! = ""
    @objc dynamic var founded: Int = 0
    @objc dynamic var id: Int = 0
    @objc dynamic var lastUpdated: String! = ""
    @objc dynamic var name: String! = ""
    @objc dynamic var phone: String! = ""
    @objc dynamic var shortName: String! = ""
    @objc dynamic var tla: String! = ""
    @objc dynamic var venue: String! = ""
    @objc dynamic var website: String! = ""
    @objc dynamic var isOnFavoritList: Bool = false

    override static func primaryKey() -> String? {
            return "id"
    }
}

final class AreaObject: Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String! = ""
   
    override static func primaryKey() -> String? {
            return "id"
    }
    
}
