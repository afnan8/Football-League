//
//  TeamCollectionCell.swift
//  FootballLeague
//
//  Created by Afnan on 11/3/20.
//

import UIKit
import SwiftIcons

class TeamCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorsLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var favoritButton: UIButton!
    
    var team: Team!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessibilityIdentifier = "teamCellIdentifier"
//        self.nameLabel.accessibilityIdentifier = "nameLabelIdnetifier"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.team = nil
        websiteButton.setTitle(nil, for: .normal)
    }
    
    func loadCellData(_ team: Team) {
        self.team = team
        imageView.showImage(team.crestUrl)
        nameLabel.text = team.name ?? "-"
        colorsLabel.text = team.clubColors ?? "-"
        venueLabel.text = team.venue ?? "-"
        websiteButton.setTitle(team.website ?? "Link Not Available", for: .normal)
        checkIfTeamIsFavorit()
    }
    
    func checkIfTeamIsFavorit() {
        if team.isOnFavoritList {
            favoritButton.setIcon(icon: .fontAwesomeSolid(.heart), iconSize: 20, color: .red, backgroundColor: .clear, forState: .normal)
        } else {
            favoritButton.setIcon(icon: .fontAwesomeRegular(.heart), iconSize: 20, color: .red, backgroundColor: .clear, forState: .normal)
        }
    }
    
    @IBAction func openWebsitePage(_ sender: UIButton) {
        URLOpen.instance.open(team.website)
    }
    
    @IBAction func toggleFavoritAction(_ sender: UIButton) {
        team.isOnFavoritList.toggle()
        RealmManager.instance.saveObjects([team.managedObject()])
        checkIfTeamIsFavorit()
    }
}
