//
//  RetireesViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 8/26/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class RetireesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var items: [Website] = []
    let retireesRef = Database.database().reference(withPath: "retirees")
    var valueToPass: String!
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "retireesCell", for:indexPath)
        
        var groceryItem = items[indexPath.row]
        
        cell.textLabel?.text = groceryItem.title
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
        performSegue(withIdentifier: "retireesSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "retireesSegue") {
            // initialize new view controller and cast it as your view controller
            var viewController = segue.destination as! RetireesDetailViewController
            // your new view controller should have property that will store passed value
            viewController.passedValue = valueToPass
        }
    }
    
    
    
    func getData() {
        retireesRef.observe(.value, with: { snapshot in
            // 2
            var frontpages: [Website] = []
            
            for item in snapshot.children {
                // 4
                let groceryItem = Website(snapshot: item as! DataSnapshot)
                frontpages.append(groceryItem!)
            }
            
            
            // 5
            self.items = frontpages
            self.tableView.reloadData()
            
            
            
        })
        
    }

}
