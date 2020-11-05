//
//  Team.swift
//  FootballLeague
//
//  Created by Afnan on 11/3/20.
//

import Foundation

struct Team {

    var address : String!
    var area : Area!
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


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
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

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if address != nil{
            dictionary["address"] = address
        }
        if area != nil{
            dictionary["area"] = area.toDictionary()
        }
        if clubColors != nil{
            dictionary["clubColors"] = clubColors
        }
        if crestUrl != nil{
            dictionary["crestUrl"] = crestUrl
        }
        if email != nil{
            dictionary["email"] = email
        }
        if founded != nil{
            dictionary["founded"] = founded
        }
        if id != nil{
            dictionary["id"] = id
        }
        if lastUpdated != nil{
            dictionary["lastUpdated"] = lastUpdated
        }
        if name != nil{
            dictionary["name"] = name
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if shortName != nil{
            dictionary["shortName"] = shortName
        }
        if tla != nil{
            dictionary["tla"] = tla
        }
        if venue != nil{
            dictionary["venue"] = venue
        }
        if website != nil{
            dictionary["website"] = website
        }
        return dictionary
    }

}
struct Area{

    var id : Int!
    var name : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        return dictionary
    }

}
