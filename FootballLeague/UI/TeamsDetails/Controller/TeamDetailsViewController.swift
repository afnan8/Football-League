//
//  TeamDetailsViewController.swift
//  FootballLeague
//
//  Created by Afnan on 11/6/20.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    var id: Int!
    
    var teamDetailsModel: TeamDetailsAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func loadViewData() {
        
    }
    
}

extension TeamDetailsViewController {
    
    func getTeamDetails() {
        if let _ = id {
            ActivityIndicator.instance.show(self.view)
            Request.requestAPI(router: .teamDetails(id), callbackSuccess: { [weak self] (result) in
                self?.teamDetailsModel = TeamDetailsAPI(fromDictionary: result)
                if self?.teamDetailsModel != nil {
                    self?.loadViewData()
                }
            }, callbackFail: { (statusCode) in
                print(statusCode)
            }) { (result) in
                print(result)
            }
        }
    }
    
}
