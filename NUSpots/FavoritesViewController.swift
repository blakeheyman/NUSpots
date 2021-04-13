//
//  FavoritesViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/21/21.
//

import UIKit
import CollapsibleTableSectionViewController

class FavoritesViewController: ListedSpacesViewController {
    
    var sort = { (b1: Building, b2: Building) in b1.name.lowercased() < b2.name.lowercased() }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get the filtered favorites list
        self.buildings = filterBuildings()
        self.buildings.sort(by: sort)
        self.tableView.reloadData() // reload table data
    }
    
    override func filterBuildings() -> [Building] {
        let buildings = DataSingleton.sharedInstance.buildings
        var filtered: [Building] = []
        for b in buildings {
            let f = b.filterSpaces(predicate: { DataSingleton.sharedInstance.favoriteSpaces.contains($0.s_id) })
            if f != nil { filtered.append(f!) }
        }
        return filtered
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let spaceVC = segue.destination as? SpaceViewController {
            let buildingSpace = sender as! (Building, Space)
            spaceVC.building = buildingSpace.0 // set building
            spaceVC.space = buildingSpace.1 // set space
        }
    }
    
    // Select a row
    func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let space = buildings[indexPath.section].spaces[indexPath.row] // Space that was selected
        let building = buildings[indexPath.section]
        performSegue(withIdentifier: "fave-to-space", sender: (building, space))
    }
    @IBAction func questionTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Adding Favorites", message: "Favorites can be added by clicking the star icon next to any space in the Map and Search tabs.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func sortTapped(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Sort favorites by", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "A-Z", style: .default, handler: { (_) in
            let azSort = { (b1: Building, b2: Building) in b1.name.lowercased() < b2.name.lowercased() }
            self.buildings.sort(by: azSort)
            self.sort = azSort
            self.tableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Distance", style: .default, handler: { (_) in
            let distanceSort = { (b1: Building, b2: Building) in b1.distance < b2.distance }
            self.buildings.sort(by: distanceSort)
            self.sort = distanceSort
            self.tableView.reloadData()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))

        self.present(alert, animated: true, completion: nil)
    }
}
