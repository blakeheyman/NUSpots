//
//  FavoritesViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/21/21.
//

import UIKit
import CollapsibleTableSectionViewController

class ListedSpacesViewController: CollapsibleTableSectionViewController {
    
    weak var tableView: UITableView!
    var buildings: [Building] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.tableView = self.view.subviews.filter{$0 is UITableView}.first as? UITableView
        
        self.tableView.register(UINib(nibName: "SpaceTableViewCell", bundle: nil), forCellReuseIdentifier: "space-cell")
        // Do any additional setup after loading the view.
        
        self.buildings = filterBuildings()
        self.tableView.reloadData() // reload table data
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }
    
    func filterBuildings() -> [Building] {
        // Get the filtered favorites list
        let buildings = DataSingleton.sharedInstance.buildings
        var filtered: [Building] = []
        for b in buildings {
            let f = b.filterSpaces(predicate: { $0.occupancy < $0.capacity })
            if f != nil { filtered.append(f!) }
        }
        return filtered
    }
}

extension ListedSpacesViewController: CollapsibleTableSectionDelegate {
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "space-cell") as! SpaceTableViewCell
        let space = buildings[indexPath.section].spaces[indexPath.row]

        cell.delegate = self
        cell.starButton.isHighlighted = DataSingleton.sharedInstance.favoriteSpaces.contains(space.s_id)
        cell.space = space
        cell.textLabel?.text = space.name
      return cell
    }
    
    func collapsibleTableView(_ tableView: UITableView, distanceForHeaderInSection section: Int) -> Int {
        let building = self.buildings[section]
        let meters = building.distance
        let feet = meters * 3.281
        
        return Int(feet)
    }
    
    // Collapse by default
    func shouldCollapseByDefault(_ tableView: UITableView) -> Bool {
        return false
    }
    
    // Title for each section
    func collapsibleTableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return buildings[section].name
    }
}
