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
}
