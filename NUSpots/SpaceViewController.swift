//
//  SpaceViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/23/21.
//

import UIKit
import MapKit
import TagListView

class SpaceViewController: UIViewController {
    
    @IBOutlet weak var buildingLabel: UILabel!
    @IBOutlet weak var spaceLabel: UILabel!
    @IBOutlet weak var capacityLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var mapButton: UIButton!
    @IBOutlet weak var spaceTagView: TagListView!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var starLabel: UILabel!
    
    var building: Building!
    var space: Space!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.buildingLabel.text = building.name // building name
        self.spaceLabel.text = space.name.uppercased() // space name
        self.capacityLabel.text = "\(space.occupancy)/\(space.capacity)" // capacity
        roundCorner(view: self.mapButton)
        
        let isFavorite = DataSingleton.sharedInstance.favoriteSpaces.contains(space.s_id)
        
        self.starImageView.isHighlighted = isFavorite
        self.starLabel.text = isFavorite ? "Favorited" : "Favorite"
        self.starImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.starPressed)))
        
        let distanceInMeters = Measurement(value: building.distance, unit: UnitLength.meters)
        let distanceInFeet = distanceInMeters.converted(to: .feet)
        self.distanceLabel.text = "\(Int(distanceInFeet.value)) ft"
        
        self.hoursLabel.text = getHours()
        
        spaceTagView.textFont = .systemFont(ofSize: 16)
        spaceTagView.addTags(space.tags.map({$0.capitalized}))
        
        // TODO hours
        
        // TODO distance
        
        // TODO Tags
        
        // Do any additional setup after loading the view.
    }
    
    @objc func starPressed(gesture: UITapGestureRecognizer?) {
        self.starImageView.isHighlighted = !starImageView.isHighlighted
        
        if starImageView.isHighlighted {
            DataSingleton.sharedInstance.addFavorite(s_id: space.s_id)
            self.starLabel.text = "Favorited"
            //delegate.favoriteSpaces.insert(space.s_id)
        }
        else {
            DataSingleton.sharedInstance.removeFavorite(s_id: space.s_id)
            self.starLabel.text = "Favorite"
            //delegate.favoriteSpaces.remove(space.s_id)
        }
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
    
    private func getHours() -> String {
        let index = Calendar.current.component(.weekday, from: Date())
        let hours = self.building.hours[index]
        
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        let open24 = df.date(from: hours.open)
        let close24 = df.date(from: hours.close)
        
        let dfPrint = DateFormatter()
        dfPrint.dateFormat = "h:mm a"
        let open12 = dfPrint.string(from: open24 ?? Date())
        let close12 = dfPrint.string(from: close24 ?? Date())
        
        return "\(open12)\n\(close12)"
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
