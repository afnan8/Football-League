//
//  Request.swift
//  FootballLeague
//
//  Created by Afnan on 11/3/20.
//

import Alamofire

class Request {
    
    static func requestAPI(router: Router, callbackSuccess: (([String:Any])->())?, callbackFail: ((Int?)->())?, callbackEndDueToError: ((String)->())?) {
        
        if !Connectivity.isConnectedToInternet() {
            //no internet page
        } else {
            AF.request(router).responseJSON { (response:DataResponse) in
                switch(response.result) {
                case .success(_):
                    if (response.value as? [String: Any]) != nil {
                        let objects = response.value as? [String: Any]
                        if response.response?.statusCode == 200 {
                            callbackSuccess!(objects!)
                        } else {
                            callbackFail!(response.response?.statusCode)
                        }
                    }
                    break
                case .failure(_):
                    callbackEndDueToError!((response.error?.localizedDescription)!)
                    break
                }
            }
        }
    }
}

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
