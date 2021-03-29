//
//  Space.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/22/21.
//

import Foundation

class Space: Codable {
    var s_id: String = ""
    var name: String = ""
    var occupancy: Int = 0
    var capacity: Int = 0
    var tags: [String] = []
}
