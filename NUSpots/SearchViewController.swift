//
//  SearchViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/21/21.
//

import UIKit
import TagListView

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    var tags: [String] = ["1 seat available"]
    var query: String = ""
    var resultsVC: ResultsViewController!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTagsView: TagListView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
        self.searchBar.text = query
        self.searchTagsView.removeAllTags()
        self.searchTagsView.addTags(tags)
        updateFilters(query: query, tags: tags)
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
    
    func updateFilters(query: String, tags: [String]) {
        resultsVC.updateFilters(query: query, tags: self.tags)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.query = searchText
        self.updateFilters(query: searchText, tags: tags)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.text = nil
            searchBar.showsCancelButton = false

            // Remove focus from the search bar.
            searchBar.endEditing(true)

            // Perform any necessary work.  E.g., repopulating a table view
            // if the search bar performs filtering.
        }
}
