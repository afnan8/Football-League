//
//  TeamCollectionCell.swift
//  FootballLeague
//
//  Created by Afnan on 11/3/20.
//

import UIKit

class TeamCollectionCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorsLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func loadCellData(_ team: Team) {
        nameLabel.text = team.name
        colorsLabel.text = team.clubColors
        venueLabel.text = "\(team.area.name) \(team.address)"
    }
}
