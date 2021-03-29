//
//  FilterTableViewController.swift
//  NUSpots
//
//  Created by Blake Heyman on 3/25/21.
//

import UIKit

class FilterTableViewController: UITableViewController {
    
    var sections: [[String : Clearable]] = DataSingleton.sharedInstance.sections
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
//        let spaceTypes = ["Classroom" : false, "Private space" : false, "Tent" : false, "Common area" : false, "Library space" : false]
//        let qualities = ["Food allowed" : false, "No eating allowed" : false, "Quiet spot" : false, "Good for groups" : false]
//        let forGroups = ["Seats available" : 1]
//        self.sections = [spaceTypes, qualities, forGroups]

        
        self.tableView.allowsSelection = false
        self.tableView.separatorStyle = .none
        self.tableView.rowHeight = 52
        self.tableView.register(UINib(nibName: "CheckboxTableViewCell", bundle: nil), forCellReuseIdentifier: "checkbox")
        self.tableView.register(UINib(nibName: "CounterTableViewCell", bundle: nil), forCellReuseIdentifier: "counter")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Type of space"
        case 1:
            return "Qualities"
        case 2:
            return "For groups"
        default:
            return "ERROR"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        let currentList = sections[indexPath.section]
        let keys = Array(currentList.keys).sorted()
        
        if indexPath.section <= 1 {
            let checkboxCell = tableView.dequeueReusableCell(withIdentifier: "checkbox", for: indexPath) as! CheckboxTableViewCell
            
            let key = keys[indexPath.row]
            checkboxCell.checkboxLabel.text = key
            checkboxCell.checkbox.isHighlighted = currentList[key] as! Bool
            checkboxCell.delegate = self
            cell = checkboxCell
        }
        else {
            let counterCell = tableView.dequeueReusableCell(withIdentifier: "counter", for: indexPath) as! CounterTableViewCell
            
            let key = keys[indexPath.row]
            counterCell.cellLabel.text = key
            counterCell.stepperCount.text = currentList[key]?.toString() ?? "Error"
            counterCell.delegate = self
            counterCell.groupsizeStepper.value = Double(currentList[key] as! Int)

            cell = counterCell
        }
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).contentView.backgroundColor = UIColor.white
        (view as! UITableViewHeaderFooterView).textLabel?.textColor = UIColor.black
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func clearRows() {
        for n in 0..<sections.count {
            for (str, c) in sections[n] {
                sections[n][str] = c.clear()
            }
        }
    }
    
    func updateSectionValue(sectionName: String, value: Clearable) {
        for n in 0 ..< sections.count {
            for (_, _) in sections[n] {
                if sections[n][sectionName] != nil {
                    sections[n][sectionName] = value
                    return;
                }
            }
        }
    }
}
