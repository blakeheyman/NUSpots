//
//  FilterViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/25/21.
//

import UIKit

class FilterViewController: UIViewController {
    
    @IBOutlet weak var clearAllButton: UIButton!
    @IBOutlet weak var showSpacesButton: UIButton!
    
    var searchDelegate: SearchViewController!
    var filterTVC: FilterTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let buttonHeight = self.clearAllButton.frame.height
        
        self.clearAllButton.layer.borderWidth = 2
        self.clearAllButton.layer.borderColor = UIColor.init(red: 204.0/255.0, green: 42.0/255.0, blue: 20.0/255.0, alpha: 1.0).cgColor
        self.clearAllButton.layer.cornerRadius = buttonHeight / 2
        self.showSpacesButton.layer.cornerRadius = buttonHeight / 2
        
        // Do any additional setup after loading the view.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destination = segue.destination
        if let filterTableViewController = destination as? FilterTableViewController {
            self.filterTVC = filterTableViewController
        }
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
    
    @IBAction func xPressed(_ sender: UIBarButtonItem) {
        clearAll()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showSpacesPressed(_ sender: UIButton) {
        var tags: [String] = []
        for s in filterTVC.sections {
            for (str, c) in s {
                print((str, c))
                if c.toString() == "true" {
                    tags.append(str)
                }
                else if c.toString() == "false" {
                    continue
                }
                else { // Must be an integer
                    tags.append("\(c.toString()) \(str)")
                }
            }
        }
        searchDelegate.searchTagsView.removeAllTags()
        searchDelegate.searchTagsView.addTags(tags)
        searchDelegate.tags = tags
        DataSingleton.sharedInstance.sections = filterTVC.sections
        self.searchDelegate.updateFilters(query: searchDelegate.query, tags: tags)
        self.dismiss(animated: true, completion: nil/*{ NotificationBanner.show("Filters applied", color: UIColor(named: "NU Turquoise") ?? UIColor.systemRed) }*/)
    }
    
    @IBAction func clearAllPressed(_ sender: UIButton) {
        clearAll()
    }
    
    private func clearAll() {
        filterTVC.clearRows()
        filterTVC.tableView.reloadData()
    }
}
