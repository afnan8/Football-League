//
//  Team.swift
//  FootballLeague
//
//  Created by Afnan on 11/3/20.
//

import Foundation

struct Team {

    var address : String!
    var area : Area?
    var clubColors : String!
    var crestUrl : String!
    var email : String!
    var founded : Int!
    var id : Int!
    var lastUpdated : String!
    var name : String!
    var phone : String!
    var shortName : String!
    var tla : String!
    var venue : String!
    var website : String!
    var isOnFavoritList: Bool = false
    
    init(fromDictionary dictionary: [String:Any]){
        address = dictionary["address"] as? String
        if let areaData = dictionary["area"] as? [String:Any]{
                area = Area(fromDictionary: areaData)
            }
        clubColors = dictionary["clubColors"] as? String
        crestUrl = dictionary["crestUrl"] as? String
        email = dictionary["email"] as? String
        founded = dictionary["founded"] as? Int
        id = dictionary["id"] as? Int
        lastUpdated = dictionary["lastUpdated"] as? String
        name = dictionary["name"] as? String
        phone = dictionary["phone"] as? String
        shortName = dictionary["shortName"] as? String
        tla = dictionary["tla"] as? String
        venue = dictionary["venue"] as? String
        website = dictionary["website"] as? String
    }
}

extension Team: Persistable {
    
    public init(managedObject: TeamObject) {
        address = managedObject.address
        if let areaObjc = managedObject.area {
            area = Area(managedObject: areaObjc)
        }
        clubColors = managedObject.clubColors
        crestUrl = managedObject.crestUrl
        email = managedObject.email
        founded = managedObject.founded
        id = managedObject.id
        lastUpdated = managedObject.lastUpdated
        name = managedObject.name
        phone = managedObject.phone
        shortName = managedObject.shortName
        tla = managedObject.tla
        venue = managedObject.venue
        website = managedObject.website
        isOnFavoritList = managedObject.isOnFavoritList
    }
    
    public func managedObject() -> TeamObject {
        let team = TeamObject()
        team.isOnFavoritList = isOnFavoritList
        team.address = address
        team.area = area?.managedObject()
        team.clubColors = clubColors
        team.crestUrl = crestUrl
        team.email = email
        team.founded = founded
        team.id = id
        team.lastUpdated = lastUpdated
        team.name = name
        team.phone = phone
        team.shortName = shortName
        team.tla = tla
        team.venue = venue
        team.website = website
    
        return team
    }
}


struct Area {

    var id : Int!
    var name : String!

    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
    }
}

extension Area: Persistable {
    
    public init(managedObject: AreaObject) {
        id = managedObject.id
        name = managedObject.name
    }
    public func managedObject() -> AreaObject {
        let area = AreaObject()
        area.id = id
        area.name = name
        return area
    }
}

