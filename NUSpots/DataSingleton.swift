//
//  Buildings.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/22/21.
//

import Foundation

class DataSingleton {
    static let sharedInstance = DataSingleton()
    
    var buildings: [Building] = []
    var favoriteSpaces = Set<String>() // IDs of favorited spaces
    var sections: [[String : Clearable]] = [[:]]
    
    private init() {
        
        // buildings
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let buildingList = try! decoder.decode(BuildingList.self, from: data)
                
                var available: [Building] = []
                for b in buildingList.buildings {
                    let cur = b.filterSpaces(predicate: {$0.occupancy < $0.capacity})
                    if cur != nil {
                        available.append(cur!)
                    }
                }
                self.buildings = available
            } catch {
                // handle error
            }
        }
        
        // favoriteSpaces
        favoriteSpaces = Set(UserDefaults.standard.array(forKey: "favoriteSpaces") as? [String] ?? [])
        
        // filteredSections
        sections = [
            ["Classroom" : false, "Private space" : false, "Tent" : false, "Common area" : false, "Library space" : false],["Food allowed" : false, "Quiet spot" : false, "Good for groups" : false], ["Seats available" : 1]]
    }
    
    func addFavorite(s_id: String) {
        favoriteSpaces.insert(s_id)
        UserDefaults.standard.setValue(Array(favoriteSpaces), forKey: "favoriteSpaces")
        UserDefaults.standard.synchronize()
        
        print("Favorite \(s_id) added")
        print(favoriteSpaces)
    }
    
    func removeFavorite(s_id: String) {
        favoriteSpaces.remove(s_id)
        UserDefaults.standard.setValue(Array(favoriteSpaces), forKey: "favoriteSpaces")
        UserDefaults.standard.synchronize()
        
        print("Favorite \(s_id) removed")
        print(favoriteSpaces)
    }
}
