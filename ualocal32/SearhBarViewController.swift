//
//  SearhBarViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 9/1/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase


class SearhBarViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var searchInput: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Website] = []
    
    var valueToPass:String!
    var input: String!
    
    let searchRef = Database.database().reference(withPath: "website")
    var selectedTask: Website?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.searchInput.delegate = self
        
        
        

        
        
        
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var input = searchInput.text
        
        searchRef.queryOrdered(byChild: "term_node_tid").queryEqual(toValue: input!).observe(.value, with: { snapshot in
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for:indexPath)
        
        var groceryItem = items[indexPath.row]
        
        cell.textLabel?.text = groceryItem.title
        cell.detailTextLabel?.text = groceryItem.key

       
        return cell
        
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Get Cell Label
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
        
        valueToPass = currentCell.detailTextLabel?.text
         print("test \(valueToPass)")
        performSegue(withIdentifier: "searchSegue", sender: self)
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "searchSegue"{
            if let destination =
                segue.destination as? SeachResultsViewController {
                destination.passedValue = valueToPass
            }
        }
    }
  
    

    

    

 

}
 
