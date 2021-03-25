//
//  SpaceViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/23/21.
//

import UIKit
import MapKit

class SpaceViewController: UIViewController {
    
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var classroomTagView: UIView!
    @IBOutlet weak var eatingTagView: UIView!
    @IBOutlet weak var eatingWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var eatingLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var quietTagView: UIView!
    @IBOutlet weak var mapButton: UIButton!
    
    var building: Building!
    var space: Space!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buildingLabel.text = building.name // building name
        self.spaceLabel.text = space.name.uppercased() // space name
        self.capacityLabel.text = "\(space.occupancy)/\(space.capacity)" // capacity
        for v: UIView in [classroomTagView, eatingTagView, quietTagView, mapButton] {
            roundCorner(view: v)
        }
        
        
        // TODO hours
        
        // TODO distance
        
        // TODO Tags
        eatingTagView.isHidden = !space.eating
        eatingWidthConstraint.constant = space.eating ? 96 : 0
        eatingLeadingConstraint.constant = space.eating ? 10 : 0
        
        quietTagView.isHidden = !space.quiet
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func openMapsPressed(_ sender: UIButton) {
        let coordinates = CLLocationCoordinate2DMake(building.latitude, building.longitude)
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = building.name
        let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeWalking]
        mapItem.openInMaps(launchOptions: options)
    }
    
    private func roundCorner(view: UIView) -> Void {
        let width = view.frame.width
        let height = view.frame.height
        let roundOn = min(width, height)
        view.layer.cornerRadius = roundOn / 2
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
