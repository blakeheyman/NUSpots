//
//  FavoritesViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/21/21.
//

import UIKit
import CollapsibleTableSectionViewController

class FavoritesViewController: CollapsibleTableSectionViewController {
    
    var buildings: [Building] = DataSingleton.sharedInstance.buildings

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        // Do any additional setup after loading the view.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let spaceVC = segue.destination as? SpaceViewController {
            let buildingSpace = sender as! (Building, Space)
            spaceVC.building = buildingSpace.0 // set building
            spaceVC.space = buildingSpace.1 // set space
        }
    }

}

extension FavoritesViewController: CollapsibleTableSectionDelegate {
    
    // Number of sections
    func numberOfSections(_ tableView: UITableView) -> Int {
        return buildings.count
    }
    
    // Number of rows in a section
    func collapsibleTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return buildings[section].spaces.count
    }
    
    // Returns a cell
    func collapsibleTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as UITableViewCell? ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let space = buildings[indexPath.section].spaces[indexPath.row]

        cell.textLabel?.text = space.name
      return cell
    }
    
    // Collapse by default
    func shouldCollapseByDefault(_ tableView: UITableView) -> Bool {
        return false
    }
    
    // Title for each section
    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return buildings[section].name
    }
    
    // Select a row
    func collapsibleTableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let space = buildings[indexPath.section].spaces[indexPath.row] // Space that was selected
        let building = buildings[indexPath.section]
        performSegue(withIdentifier: "fave-to-space", sender: (building, space))
    }
}
