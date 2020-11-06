//
//  TeamDetailsAPI.swift
//  FootballLeague
//
//  Created by Afnan on 11/6/20.
//

import Foundation

struct TeamDetailsAPI {

    var activeCompetitions : [ActiveCompetition]!
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
    var squad : [Squad]!
    var tla : String!
    var venue : String!
    var website : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        activeCompetitions = [ActiveCompetition]()
        if let activeCompetitionsArray = dictionary["activeCompetitions"] as? [[String:Any]]{
            for dic in activeCompetitionsArray{
                let value = ActiveCompetition(fromDictionary: dic)
                activeCompetitions.append(value)
            }
        }
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
        squad = [Squad]()
        if let squadArray = dictionary["squad"] as? [[String:Any]]{
            for dic in squadArray{
                let value = Squad(fromDictionary: dic)
                squad.append(value)
            }
        }
        tla = dictionary["tla"] as? String
        venue = dictionary["venue"] as? String
        website = dictionary["website"] as? String
    }
}

struct Squad {

    var countryOfBirth : String!
    var dateOfBirth : String!
    var id : Int!
    var name : String!
    var nationality : String!
    var position : String!
    var role : String!
    var shirtNumber : Int!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        countryOfBirth = dictionary["countryOfBirth"] as? String
        dateOfBirth = dictionary["dateOfBirth"] as? String
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        nationality = dictionary["nationality"] as? String
        position = dictionary["position"] as? String
        role = dictionary["role"] as? String
        shirtNumber = dictionary["shirtNumber"] as? Int
    }

}

struct ActiveCompetition{

    var area : Area!
    var code : String!
    var id : Int!
    var lastUpdated : String!
    var name : String!
    var plan : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        if let areaData = dictionary["area"] as? [String:Any]{
                area = Area(fromDictionary: areaData)
            }
        code = dictionary["code"] as? String
        id = dictionary["id"] as? Int
        lastUpdated = dictionary["lastUpdated"] as? String
        name = dictionary["name"] as? String
        plan = dictionary["plan"] as? String
    }
}
