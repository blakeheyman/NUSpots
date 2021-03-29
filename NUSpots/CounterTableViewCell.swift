//
//  CounterTableViewCell.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/25/21.
//

import UIKit

class CounterTableViewCell: UITableViewCell {
    
    var delegate: FilterTableViewController!

    @IBOutlet weak var groupsizeStepper: UIStepper!
    @IBOutlet weak var stepperCount: UILabel!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        stepperCount.text = "\(Int(sender.value))"
        self.delegate.updateSectionValue(sectionName: cellLabel.text ?? "Error", value: Int(sender.value))
    }
}

//extension CounterTableViewCell: Clearable {
//    func clear() {
//        stepperCount.text = "1"
//        groupsizeStepper.value = 1
//        self.delegate.groupSize = 1
//    }
//}
