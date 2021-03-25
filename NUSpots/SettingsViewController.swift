//
//  SettingsViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/21/21.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var advancedSettings: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func locationSwitchToggled(_ sender: UISwitch) {
        // TODO Turn location on/off
    }
    
    @IBAction func notificationSwitchToggled(_ sender: UISwitch) {
        if (sender.isOn) {
            // TODO Turn notifications on
            
            // Show view
            advancedSettings.isHidden = false;
        }
        else {
            // TODO Turn notifications off
            
            // Hide view
            advancedSettings.isHidden = true;
        }
    }
}
