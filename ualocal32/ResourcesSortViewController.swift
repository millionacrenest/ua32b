//
//  ResourcesSortViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 11/8/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit

class ResourcesSortViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var valueToPass: String!
    var tags = ["Benefits", "Dispatch", "Membership", "Other Forms", "Scholarships", "Work Recovery", "Agent Reports", "Business Manager Reports", "Connection Magazine", "Other Publications"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resourceMenuCell", for:indexPath)
    
        var groceryItem = tags[indexPath.row]
        cell.textLabel?.text = groceryItem
        
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        
        var groceryItem = tags[indexPath.row]
        self.valueToPass = groceryItem
        print("valueTopass: \(valueToPass)")
        performSegue(withIdentifier: "ResourceByTag", sender: self)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResourceByTag"{
            if let destination = segue.destination as? ResourcesViewController {
                destination.valueToSearch = valueToPass
                
            }
        }
    }

}
