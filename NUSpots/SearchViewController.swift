//
//  SearchViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/21/21.
//

import UIKit
import TagListView

class SearchViewController: UIViewController {
    
    var tags: [String] = []
    var resultsVC: ResultsViewController!

    @IBOutlet weak var searchTagsView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination
        if let filterVC = destination as? FilterViewController {
            filterVC.searchDelegate = self
        }
        if let resultsVC = destination as? ResultsViewController {
            self.resultsVC = resultsVC
            resultsVC.searchVC = self
        }
        if let spaceVC = destination as? SpaceViewController {
            let buildingSpace = sender as! (Building, Space)
            spaceVC.building = buildingSpace.0 // set building
            spaceVC.space = buildingSpace.1 // set space
        }
    }
    
    func updateFilters(tags: [String]) {
        resultsVC.updateFilters(tags: self.tags)
    }
}
