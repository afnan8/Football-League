//
//  TeamDetailsViewController.swift
//  FootballLeague
//
//  Created by Afnan on 11/6/20.
//

import UIKit

class TeamDetailsViewController: UIViewController {
    
    private let squadCellIdentifier = "squadCellIdentifier"
    
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var foundedLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
    
    var id: Int!
    
    var teamDetailsModel: TeamDetailsAPI!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        getTeamDetails()
    }
    
    func setupCollectionView() {
        let nib = UINib(nibName: "SquadCollectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: squadCellIdentifier)
    }
    
    func loadViewData() {
        self.navigationItem.title = teamDetailsModel.shortName ?? teamDetailsModel.name ?? ""
        teamImageView.showImage(teamDetailsModel.crestUrl)
        nameLabel.text = teamDetailsModel.name
        foundedLabel.text = "Founded: \(teamDetailsModel.founded ?? 0)"
        collectionView.reloadData()
        self.view.layoutIfNeeded()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.reloadData()
        self.collectionViewHeightConstraint.constant = self.collectionView.contentSize.height
        self.collectionViewHeightConstraint.isActive = true
        collectionView.reloadData()
    }
    
}

extension TeamDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let _ = teamDetailsModel {
            return teamDetailsModel.squad != nil ? teamDetailsModel.squad.count : 0
        }
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: squadCellIdentifier, for: indexPath)
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
        return CGSize(width: width / 3 - 15, height: 174)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cell = cell as! SquadCollectionCell
        cell.loadCellData(teamDetailsModel.squad[indexPath.row])
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
