//
//  ResourcesViewController.swift
//  
//
//  Created by Allison Mcentire on 8/24/17.
//
//

import UIKit
import Firebase
import FirebaseDatabase

class ResourcesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var valueToPass: String!
    var valueToSearch: String!

    let resourcesRef = Database.database().reference(withPath: "resources")
    
    var items: [Website] = []

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let query = resourcesRef.queryOrdered(byChild: "field_tag").queryEqual(toValue: valueToSearch!)
        
        print("\(query)")
        query.observe(.value, with: { snapshot in
            // 2
            var frontpages: [Website] = []
            
            for item in snapshot.children {
                // 4
                let groceryItem = Website(snapshot: item as! DataSnapshot)
                
             
                    self.items.append(groceryItem!)
                    
                }
            
            
            
            // 5
            
            self.tableView.reloadData()
            
           
        })
        
        
    

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "resourceCell", for:indexPath)
        var groceryItem = items[indexPath.row]
        
    
        let rawURL = "https://ua32.net\(groceryItem.field_document_file)"

        cell.textLabel?.text = groceryItem.name
        cell.detailTextLabel?.text = groceryItem.field_document_file

        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
   
            var groceryItem = items[indexPath.row]
            self.valueToPass = groceryItem.field_document_file
        
        
       // valueToPass = groceryItem.field_document_file
        performSegue(withIdentifier: "ResourceDetailVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResourceDetailVC"{
            if let destination =
                segue.destination as? PDFReadViewController {
                destination.passedValue = valueToPass
            }
        }
    }
   
    
    


}
