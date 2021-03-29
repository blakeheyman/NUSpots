//
//  SpaceTableViewCell.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/25/21.
//

import UIKit

class SpaceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var starButton: UIImageView!
    
    var space: Space!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        starButton.isHighlighted = true
        starButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.starPressed)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func starPressed(gesture: UITapGestureRecognizer?) {
        starButton.isHighlighted = !starButton.isHighlighted
        
        if starButton.isHighlighted {
            DataSingleton.sharedInstance.addFavorite(s_id: space.s_id)
        }
        else {
            DataSingleton.sharedInstance.removeFavorite(s_id: space.s_id)
        }
    }
}
