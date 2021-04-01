//
//  MapRecommendedViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/29/21.
//

import UIKit

class MapRecommendedViewController: ListedSpacesViewController {
    
    var mapVC: MapViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resort()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        //        // Get the filtered favorites list
//        //        let buildings = DataSingleton.sharedInstance.buildings
//        //        let filteredBuildings = buildings//.filter{ $0.spaces.contains{ favoriteSpaces.contains($0.s_id) } }
//        //        for b in filteredBuildings {
//        //            b.spaces = b.spaces.filter { s -> Bool in self.tags.allSatisfy({ s.tags.contains($0) }) }
//        //        }
//        //        self.buildings = filteredBuildings
//        //
//        //        self.tableView.reloadData() // reload table data
//        //self.buildings = DataSingleton.sharedInstance.buildings
//    }
//
//    func updateFilters(query: String, tags: [String]) {
//        // Get the filtered favorites list
//
//        let tagMatch = { (s: Space) -> Bool in s.name.starts(with: query) && tags.allSatisfy({ s.tags.contains($0.lowercased())
//            || ($0 == tags.last
//                    && Int($0) ?? 1 < s.capacity - s.occupancy)
//        }) }
//        // Get the filtered favorites list
//        let buildings = DataSingleton.sharedInstance.buildings
//        var filtered: [Building] = []
//        for b in buildings {
//            let f = b.filterSpaces(predicate:
//                                    { (s: Space) -> Bool in (b.name.starts(with: query) || s.name.starts(with: query)) && tags.allSatisfy({ s.tags.contains($0.lowercased())
//                                        || ($0 == tags.last
//                                                && Int($0) ?? 1 < s.capacity - s.occupancy)
//                                    }) })
//            if f != nil { filtered.append(f!) }
//        }
//        self.buildings = filtered
//        self.tableView.reloadData() // reload table data
//    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // Select a row
    func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let space = buildings[indexPath.section].spaces[indexPath.row] // Space that was selected
        let building = buildings[indexPath.section]
        mapVC.performSegue(withIdentifier: "fave-to-space", sender: (building, space))
    }
    
//    // Collapse by default
//    override func shouldCollapseByDefault(_ tableView: UITableView) -> Bool {
//        return true
//    }
    
    func resort() {
        self.buildings.sort(by: { (b1: Building, b2: Building) in b1.distance < b2.distance })
        self.tableView.reloadData()
    }
}
