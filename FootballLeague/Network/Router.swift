//
//  Router.swift
//  FootballLeague
//
//  Created by Afnan on 11/3/20.
//

import Alamofire

enum Router: URLRequestConvertible {
    
    static var baseURL = "https://api.football-data.org/"
    
    case teamSubresource
    
    var url: URL {
        switch self {
        case .teamSubresource:
            return URL(string: Router.baseURL + "v2/competitions/2001/teams")!
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var header: HTTPHeaders {
        let header: HTTPHeaders = ["X-Auth-Token": "83f37ab5c4ef47dabf2e3fb0fff20fee"]
        return header
    }
    
    var parameter: Parameters? {
        switch self {
        case .teamSubresource:
            return [:]
        }
    }

    func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        urlRequest.headers = header
//        urlRequest.enco
        return urlRequest
    }
}

