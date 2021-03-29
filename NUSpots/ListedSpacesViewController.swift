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
    var favoriteSpaces: Set<String> = DataSingleton.sharedInstance.favoriteSpaces

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        self.tableView = self.view.subviews.filter{$0 is UITableView}.first as? UITableView
        
        self.tableView.register(UINib(nibName: "SpaceTableViewCell", bundle: nil), forCellReuseIdentifier: "space-cell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Get the filtered favorites list
        let buildings = DataSingleton.sharedInstance.buildings
        let filteredBuildings = buildings.filter{ $0.spaces.contains{ favoriteSpaces.contains($0.s_id) } }
        for b in filteredBuildings {
            b.spaces = b.spaces.filter { favoriteSpaces.contains($0.s_id) }
        }
        self.buildings = filteredBuildings

        self.tableView.reloadData() // reload table data
        //self.buildings = DataSingleton.sharedInstance.buildings
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

        cell.space = space
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
}
