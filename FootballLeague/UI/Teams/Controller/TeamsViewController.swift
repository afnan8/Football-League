//
//  TeamsViewController.swift
//  FootballLeague
//
//  Created by Afnan on 11/3/20.
//

import UIKit

class TeamsViewController: UIViewController {
    
    private let teamCellIdentifier = "teamCellIdentifier"
    
    @IBOutlet weak var collectionView: UICollectionView!
    var teamDetailsViewController = TeamDetailsViewController()

    var teamsFromAPI: [Team]! //has all teams loaded from API
    lazy var teams = [Team]() //has team pages
    
    var isFinish = false
    var count = 0
    var start = 0
    let length = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        NetworkListener.instance.delegate = self
        self.navigationItem.title = "Premier League Teams"
        setupCollectionView()
        getAllTeams()
    }
    
    func setupCollectionView() {
        let nib = UINib(nibName: "TeamCollectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: teamCellIdentifier)
        collectionView.accessibilityIdentifier = "teamCollectionViewIdentifier"
    }
    
    func openDetailsViewController(_ index: Int) {
        let teamDetailsViewController = TeamDetailsViewController()
        teamDetailsViewController.id = teams[index].id
        self.navigationController?.pushViewController(teamDetailsViewController, animated: true)
    }
}

extension TeamsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return teams.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamCellIdentifier, for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets  {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        var height = collectionView.bounds.height * 0.2
        if height < 150 {
            height = 150
        }
        return CGSize(width: width - 20, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! TeamCollectionCell
        cell.loadCellData(teams[indexPath.row])
        cell.addLineToView(position: .bottom, color: #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openDetailsViewController(indexPath.row)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
                if !isFinish {
                    loadTeamPage()
                }
            }
        }
    }
}

//extension TeamsViewController: NetworkStatusDelegate {
//    func isNetworkConnected(_ isConnected: Bool) {
//        if isConnected {
//
//        } else {
//
//        }
//    }
//}

extension TeamsViewController { // API Handling
    
    func getAllTeams() {
        if !Connectivity.isConnectedToInternet() { //No internetConnection
            getTeamsFromLocalStorage()
            self.collectionView.reloadData()
        } else {
            getTeamsFromAPI()
        }
    }
    
    func getTeamsFromAPI() {
        ActivityIndicator.instance.show(self.view)
        Request.requestAPI(router: .teamSubresource, callbackSuccess: { [weak self] (result) in
            let teamsArray = result["teams"] as? [[String:Any]]
            if teamsArray != nil {
                self?.loadTeamMember(teamsArray)
                self?.loadTeamPage()
            } else {
                print("No teams Available")
            }
        }, callbackFail: { (statusCode) in
            //                            AppAlert.instance.show("error".localized(), message ?? "UnknownError", self)
        }) { (result) in
            print(result)
        }
    }
    
    func loadTeamMember(_ teamsList: [[String: Any]]?) {
        self.teamsFromAPI = [Team]()
        if let teamsDic = teamsList {
            for dic in teamsDic {
                let value = Team(fromDictionary: dic)
                self.teamsFromAPI.append(value)
            }
        }
    }
    
    func loadTeamPage() {
        count += length
        checkIfLoadingFinish()
        let arr = teamsFromAPI[start..<count]
        teams.append(contentsOf: arr)
        start = count
        saveTeamsToLocalStorage(Array(arr))
        self.collectionView.reloadData()
    }
    
    func checkIfLoadingFinish() {
        if count > teamsFromAPI.count {
            count = teamsFromAPI.count
            isFinish = true
        }
    }  
}

extension TeamsViewController { //datebase Handling
    
    func saveTeamsToLocalStorage(_ teams: [Team]) {
        var teamsObject = [TeamObject]()
        for (team) in teams {
            let teamObj = team.managedObject()
            teamObj.isOnFavoritList = isTeamOnFavList(team.id)
            teamsObject.append(teamObj)
        }
        RealmManager.instance.saveObjects(Array(teamsObject))
    }
    
    func isTeamOnFavList(_ id: Int) -> Bool {
        let objc = RealmManager.instance.getSavedObject(TeamObject(), id)
        _ = teams.enumerated().map() {
            if $1.id == id {
                teams[$0].isOnFavoritList = objc?.isOnFavoritList ?? false
                return
            }
        }
        return  objc?.isOnFavoritList ?? false
    }
    
    func getTeamsFromLocalStorage() {
        let teamsObject = RealmManager.instance.getAllSavedObjects(TeamObject())
        for teamObj in teamsObject {
            let team = Team(managedObject: teamObj)
            self.teams.append(team)
        }
        isFinish = true //To disable load in scroll in offline mode
    }
    
}
