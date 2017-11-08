//
//  ContactsSortViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 10/6/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ContactsSortViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var segementedControl: UISegmentedControl!
    
    var items: [Contacts] = []
    
    let ref1 = Database.database().reference(withPath:"contractors").queryOrdered(byChild: "field_company")
    let ref2 = Database.database().reference(withPath:"contractors").queryOrdered(byChild: "field_contact")
    let ref3 = Database.database().reference(withPath:"contractors").queryOrdered(byChild: "field_contractor_type")
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
       
        print("\(items)")
        getData1()

        // Do any additional setup after loading the view.
    }
    
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for:indexPath) as! ContractorTableViewCell
        
        var groceryItem = items[indexPath.row]
        
        cell.companyLabel?.text = groceryItem.field_company
        cell.contactLabel?.text = groceryItem.field_contact
        cell.typeLabel?.text = groceryItem.field_contractor_type
        cell.phoneView?.text = groceryItem.field_phone
        
        
        //        cell.tagLabel?.text = groceryItem.field_tag
        //        cell.imageURLStringLabel?.text = groceryItem.field_image
        //        cell.bodyStringLabel?.text = groceryItem.body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func getData1() {
        
        ref1.observe(.value, with: { snapshot in
            
         
            // 2
            var frontpages: [Contacts] = []
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                frontpages.append(groceryItem!)
            }
            
            
            // 5
            self.items = frontpages
            self.tableView.reloadData()
            
            
            
        })
        
    }
    
    func getData2() {
        ref2.observe(.value, with: { snapshot in
            
           
            // 2
            var frontpages: [Contacts] = []
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                frontpages.append(groceryItem!)
            }
            
            
            // 5
            self.items = frontpages
            self.tableView.reloadData()
            
            
            
        })
        
        
    }
    
    func getData3() {
        ref3.observe(.value, with: { snapshot in
            
        
            
            // 2
            var frontpages: [Contacts] = []
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                frontpages.append(groceryItem!)
            }
                // 5
                self.items = frontpages
                self.tableView.reloadData()
            
            
  
        })
        
    }
    
    
    @IBAction func selectedSort(_ sender: Any) {
        
        
        switch segementedControl.selectedSegmentIndex {
        case 0:
            getData1()
        case 1:
            getData2()
        case 2:
            getData3()
        default:
            break;
        }
    }
    
    
    
    
    

}
