//
//  CheckboxTableViewCell.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/25/21.
//

import UIKit

class CheckboxTableViewCell: UITableViewCell {
    
    var delegate: FilterTableViewController!

    @IBOutlet weak var checkboxLabel: UILabel!
    @IBOutlet weak var checkbox: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        checkbox.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.checkboxPressed)))
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @objc func checkboxPressed(gesture: UITapGestureRecognizer?) {
        checkbox.isHighlighted = !checkbox.isHighlighted
        self.delegate.updateSectionValue(sectionName: self.checkboxLabel.text ?? "Error", value: checkbox.isHighlighted)
    }
}

//extension CheckboxTableViewCell: Clearable {
//    func clear() {
//        self.isHighlighted = false
//        delegate.filters.remove(self.checkboxLabel.text)
//    }
//}
