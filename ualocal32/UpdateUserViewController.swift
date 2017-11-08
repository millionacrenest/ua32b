//
//  UpdateUserViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 9/5/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth
import SDWebImage

class UpdateUserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var profileView: UIImageView!
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    @IBOutlet weak var staffSinceLabel: UILabel!
    
    @IBOutlet weak var tagsLabel: UILabel!
    
    @IBOutlet weak var local_member_sinceLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UITextView!
    
    
    @IBOutlet weak var tableView: UITableView!
    
    let ref = Database.database().reference()
    let userID = Auth.auth().currentUser?.uid
    var childIWantToRemove: String!
    
    var sites: [NodeLocation] = []
  
    let locationsRef = Database.database().reference(withPath: "nodeLocations")
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSites()
        tableView.delegate = self
        tableView.dataSource = self
        
        let userRef = ref.child("staff")
        
        userRef.queryOrdered(byChild: "field_fbuid").queryEqual(toValue: userID!).observe(.value, with: { snapshot in
            
            for item in snapshot.children {
                guard let userData = item as? DataSnapshot else { continue }
                let userValue = userData.value as! [String: Any]
                self.fullNameLabel.text = userValue["field_full_name"] as! String
                let str = userValue["field_profile_description"] as! String
                  let strNew = str.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
                self.bioLabel.text = strNew
                var profileImageString = userValue["field_profile_picture"] as! String
                self.staffSinceLabel.text = userValue["field_on_staff_since"] as! String
                self.tagsLabel.text = userValue["field_tags"] as! String
                self.local_member_sinceLabel.text = userValue["field_local_32_member_since_"] as! String
                
                self.profileView?.sd_setImage(with: URL(string: profileImageString), placeholderImage: UIImage(named: "https://cdn.pixabay.com/photo/2017/08/12/00/17/like-2633137_1280.png"))
                
                
            }

            
        })
        
        tableView.reloadData()
        
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath as IndexPath) as! UITableViewCell
        
        let item = sites[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = item.key
        self.childIWantToRemove = item.key
     
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("Deleted")
            
            self.sites.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            myDeleteFunction(childIWantToRemove: childIWantToRemove)
        }
    }
    
    func myDeleteFunction(childIWantToRemove: String) {
        
        locationsRef.child(childIWantToRemove).removeValue { (error, ref) in
            if error != nil {
                print("error \(error)")
            }
        }
    }
    
    func fetchSites() {
        
        locationsRef.queryOrdered(byChild: "UID").queryEqual(toValue: userID!).observe(.value, with: { snapshot in
            
            var frontpages: [NodeLocation] = []
            
            for item in snapshot.children {
                let groceryItem = NodeLocation(snapshot: item as! DataSnapshot)
                frontpages.append(groceryItem!)
     
            }
            self.sites = frontpages
            self.tableView.reloadData()
        })
       
       
    }
    
    
    
 
    
    

    



}
