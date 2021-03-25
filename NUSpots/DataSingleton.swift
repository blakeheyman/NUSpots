//
//  Buildings.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/22/21.
//

import Foundation

class DataSingleton {
    static let sharedInstance = DataSingleton()
    
    var buildings: [Building]
    
    private init() {
        buildings = [] // default value
        
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let buildingList = try! decoder.decode(BuildingList.self, from: data)
                buildings = buildingList.buildings
            } catch {
                // handle error
            }
        }
    }
}
