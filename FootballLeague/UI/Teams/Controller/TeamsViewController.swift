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
    
    var teamsFromAPI: [Team]!
    lazy var teams = [Team]()
    
    var isFinish = false
    var count = 0
    var start = 0
    
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
    }
    
    func openDetailsViewController(_ index: Int) {
        let viewController = TeamDetailsViewController()
        viewController.id = teams[index].id
        self.navigationController?.pushViewController(viewController, animated: true)
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
        let height = collectionView.bounds.height
        return CGSize(width: width - 20, height: height * 0.2)
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
        } else {
            getTeamsFromAPI()
        }
    }
    
    
    func getTeamsFromAPI() {
        ActivityIndicator.instance.show(self.view)
        Request.requestAPI(router: .teamSubresource, callbackSuccess: { [weak self] (result) in
            let teamsArray = result["teams"] as? [[String:Any]]
            self?.loadTeamMember(teamsArray)
            self?.loadTeamPage()
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
        count += 6
        checkIfLoadingFinish()
        let arr = teamsFromAPI[start..<count]
        teams.append(contentsOf: arr)
        start = count
        collectionView.reloadData()
        saveTeamsToLocalStorage(Array(arr))
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
        for team in teams {
            let teamObj = team.managedObject()
            teamsObject.append(teamObj)
        }
        RealmManager.instance.saveObjects(Array(teamsObject))
    }
    
    func getTeamsFromLocalStorage() {
        let teamsObject = RealmManager.instance.getAllSavedObjects(TeamObject())
        for teamObj in teamsObject {
            let team = Team(managedObject: teamObj)
            self.teams.append(team)
        }
        isFinish = true //To disable load in scroll in offline mode
        self.collectionView.reloadData()
    }
    
}
