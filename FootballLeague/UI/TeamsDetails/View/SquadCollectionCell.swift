//
//  SquadCollectionCell.swift
//  FootballLeague
//
//  Created by Afnan on 11/7/20.
//

import UIKit

class SquadCollectionCell: UICollectionViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var nationalityLabel: UILabel!
    @IBOutlet weak var shirtNoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
        nameLabel.adjustsFontSizeToFitWidth = true
    }
    
    func setupCell() {
        self.layer.borderWidth = 1
        self.layer.borderColor = #colorLiteral(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393, alpha: 1)
        self.layer.cornerRadius = 15
    }

    func loadCellData(_ squad: Squad) {
        nameLabel.text = squad.name ?? ""
        positionLabel.text = squad.position ?? ""
        nationalityLabel.text = squad.nationality ?? ""
        if let number = squad.shirtNumber {
            shirtNoLabel.text = "\(number)"
        }
    }
}
