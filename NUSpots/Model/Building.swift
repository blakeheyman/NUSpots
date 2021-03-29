//
//  Building.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/22/21.
//

import Foundation

class Building: Codable {
    var b_id: String = ""
    var name: String = ""
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    var hours: [Hours] = []
    var spaces: [Space] = []
    
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
