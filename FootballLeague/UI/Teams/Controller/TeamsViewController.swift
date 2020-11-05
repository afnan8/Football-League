//
//  TeamsViewController.swift
//  FootballLeague
//
//  Created by Afnan on 11/3/20.
//

import UIKit

class TeamsViewController: UIViewController {

    var teams: [Team]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllTeams()
    }

}
extension TeamsViewController {
    
    func getAllTeams() {
        ActivityIndicator.instance.show(self.view)
        Request.requestAPI(router: .teamSubresource, callbackSuccess: { [weak self] (result) in
            self?.teams = [Team]()
            if let teamsArray = result["teams"] as? [[String:Any]]{
                for dic in teamsArray{
                    let value = Team(fromDictionary: dic)
                    self?.teams.append(value)
                }
            }
            print(self?.teams[0])
        }, callbackFail: { (statusCode) in
//                AppAlert.instance.show("error".localized(), message ?? "UnknownError", self)
        }) { (result) in
            print(result)
        }
    }
}
