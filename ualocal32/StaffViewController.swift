//
//  AboutViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 9/3/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class StaffViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Staff] = []
    
    var valueToPass:String!
    
    
    let aboutRef = Database.database().reference(withPath: "staff")
    var selectedTask: Website?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    
    
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "staffCell", for:indexPath)
        
        var groceryItem = items[indexPath.row]
        
        cell.textLabel?.text = groceryItem.field_full_name
        cell.detailTextLabel?.text = groceryItem.key
        
        
        //        cell.tagLabel?.text = groceryItem.field_tag
        //        cell.imageURLStringLabel?.text = groceryItem.field_image
        //        cell.bodyStringLabel?.text = groceryItem.body
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        valueToPass = currentCell.detailTextLabel?.text
        performSegue(withIdentifier: "staffSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "staffSegue") {
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destination as! StaffDetailViewController
            // your new view controller should have property that will store passed value
            viewController.passedValue = valueToPass
        }
    }
    
    
    
    
    
    
    func getData() {
        aboutRef.observe(.value, with: { snapshot in
            // 2
            var frontpages: [Staff] = []
            
            for item in snapshot.children {
                // 4
                let groceryItem = Staff(snapshot: item as! DataSnapshot)
                frontpages.append(groceryItem!)
            }
            
            
            // 5
            self.items = frontpages
            self.tableView.reloadData()
            
            
            
        })
        
    }
    
    
}
