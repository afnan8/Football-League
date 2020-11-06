//
//  TeamCollectionCell.swift
//  FootballLeague
//
//  Created by Afnan on 11/3/20.
//

import UIKit

class TeamCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var colorsLabel: UILabel!
    @IBOutlet weak var venueLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    
    var team: Team!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.team = nil
    }
    
    func loadCellData(_ team: Team) {
        self.team = team
        imageView.showImage(team.crestUrl)
        nameLabel.text = team.name ?? "-"
        colorsLabel.text = team.clubColors ?? "-"
        if let area = team.area {
            venueLabel.text = "\(area.name ?? "-")"
        }
        websiteButton.setTitle(team.website ?? "Link Not Available", for: .normal)
    }
    
    @IBAction func openWebsitePage(_ sender: UIButton) {
        URLOpen.instance.open(team.website)
    }
    
}
