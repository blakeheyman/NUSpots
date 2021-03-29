//
//  FilteredSpacesViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/26/21.
//

import UIKit

class ResultsViewController: ListedSpacesViewController {
    
    var searchVC: SearchViewController!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        // Get the filtered favorites list
//        let buildings = DataSingleton.sharedInstance.buildings
//        let filteredBuildings = buildings//.filter{ $0.spaces.contains{ favoriteSpaces.contains($0.s_id) } }
//        for b in filteredBuildings {
//            b.spaces = b.spaces.filter { s -> Bool in self.tags.allSatisfy({ s.tags.contains($0) }) }
//        }
//        self.buildings = filteredBuildings
//
//        self.tableView.reloadData() // reload table data
        //self.buildings = DataSingleton.sharedInstance.buildings
    }
    
    func updateFilters(tags: [String]) {
        // Get the filtered favorites list
        
        let tagMatch = { (s: Space) -> Bool in tags.allSatisfy({ s.tags.contains($0.lowercased())
                                                                || ($0 == tags.last
                                                                        && Int($0) ?? 1 < s.capacity - s.occupancy)
                                                                }) }
        
        let buildings = DataSingleton.sharedInstance.buildings
        let filteredBuildings = buildings.filter{ $0.spaces.contains{ tagMatch($0) } }
        for b in filteredBuildings {
            print(tags)
            b.spaces = b.spaces.filter { tagMatch($0) }
        }
        self.buildings = filteredBuildings

        self.tableView.reloadData() // reload table data
    }
    

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
        searchVC.performSegue(withIdentifier: "fave-to-space", sender: (building, space))
    }
}
