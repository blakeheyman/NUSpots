//
//  MapViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/21/21.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    var locationManager = CLLocationManager()
    let buildings = DataSingleton.sharedInstance.buildings

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapSearchBar: UISearchBar!
    
    @IBOutlet weak var foodImageView: UIImageView!
    @IBOutlet weak var groupsImageView: UIImageView!
    @IBOutlet weak var classroomImageView: UIImageView!
    @IBOutlet weak var quietImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        self.mapSearchBar.delegate = self

        let locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest

        // Check for Location Services
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.requestAlwaysAuthorization()
            locationManager.requestWhenInUseAuthorization()
        }

        //Zoom to user location
        if let userLocation = locationManager.location?.coordinate {
            let viewRegion = MKCoordinateRegion(center: userLocation, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(viewRegion, animated: false)
            mapView.showsUserLocation = true
        }
        
        else {
            let viewRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.3398, longitude: 71.0892), latitudinalMeters: 300, longitudinalMeters: 300)
            mapView.setRegion(viewRegion, animated: false)
        }
        
        for b in buildings {
            let annotation = MKPointAnnotation()
            annotation.title = b.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: b.latitude, longitude: b.longitude)
            mapView.addAnnotation(annotation)
        }
        
        self.locationManager = locationManager
        
        let ivs = [foodImageView, groupsImageView, classroomImageView, quietImageView]
        for n in 0 ..< ivs.count {
            ivs[n]?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("quickSearch\(n)pressed")))
        }
        
//        var spaces: [Space] = []
//
//        for b in buildings {
//            for s in b.spaces {
//                spaces.append(s)
//            }
//        }

        // Do any additional setup after loading the view.
    }
    
    @objc func quickSearch0pressed() {
        self.performSegue(withIdentifier: "map-to-search", sender: ("", ["Food allowed", "1 seat available"]))
    }
    
    @objc func quickSearch1pressed() {
        self.performSegue(withIdentifier: "map-to-search", sender: ("", ["Good for groups", "1 seat available"]))
    }
    
    @objc func quickSearch2pressed() {
        self.performSegue(withIdentifier: "map-to-search", sender: ("", ["Classroom", "1 seat available"]))
    }
    
    @objc func quickSearch3pressed() {
        self.performSegue(withIdentifier: "map-to-search", sender: ("", ["Quiet spot", "1 seat available"]))
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let recommendedVC = segue.destination as? MapRecommendedViewController {
            recommendedVC.mapVC = self
        }
        
        if let spaceVC = segue.destination as? SpaceViewController {
            let buildingSpace = sender as! (Building, Space)
            spaceVC.building = buildingSpace.0 // set building
            spaceVC.space = buildingSpace.1 // set space
        }
        
        if let searchVC = segue.destination as? SearchViewController {
            let queryTags = sender as! (String, [String])
            searchVC.query = queryTags.0
            searchVC.tags = queryTags.1
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView)
    {
        let annotation = view.annotation
        let query = annotation?.title
        
        self.performSegue(withIdentifier: "map-to-search", sender: (query, []))
    }
}

extension MapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        print("Here")
        let matches = self.mapView.annotations.filter({ ($0.title??.hasPrefix(query) ?? false) })
        if matches.count > 0 {
            let coords = matches.first!.coordinate
            mapView.setCenter(coords, animated: true)
        }
        else {
            let alert = UIAlertController(title: "No spaces found", message: "Make sure you spelled the building name correctly", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
        searchBar.endEditing(true)
    }
    
    
}
