//
//  Building.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/22/21.
//

import Foundation
import CoreLocation

class Building: Codable {
    var b_id: String = ""
    var name: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var hours: [Hours] = []
    var spaces: [Space] = []
    
    var distance: Double {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            let lm = CLLocationManager()
            let loc = lm.location
            let buildingLocation = CLLocation(
                latitude:  self.latitude,
                longitude: self.longitude
            )
            let distance = loc?.distance(from: buildingLocation)
            return distance ?? -1
        }
        return -1
    }
    
    func filterSpaces(predicate: (Space) -> Bool) -> Building? {
        let copy = Building()
        copy.b_id = self.b_id
        copy.name = self.name
        copy.latitude = self.latitude
        copy.longitude = self.longitude
        copy.hours = self.hours
        copy.spaces = self.spaces.filter(predicate)
        return copy.spaces.count > 0 ? copy : nil
    }
}
