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

    let resourcesRef = Database.database().reference(withPath: "resources")
    
    var items: [Website] = []
    var benefits: [Website] = []
    var dispatch: [Website] = []
    var membership: [Website] = []
    var otherForms: [Website] = []
    var scholarships: [Website] = []
    var workRecovery: [Website] = []
    var agentReports: [Website] = []
    var businessMReports: [Website] = []
    var connectionMag: [Website] = []
    var otherPublications: [Website] = []
    var isFiltered = Bool()
    let section = ["Benefits", "Dispatch", "Membership", "Other Forms", "Scholarships", "Work Recovery", "Agent Reports", "Business Manager Reports", "Connection Magazine", "Other Publications"]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        resourcesRef.observe(.value, with: { snapshot in
            // 2
            var frontpages: [Website] = []
            
            for item in snapshot.children {
                // 4
                let groceryItem = Website(snapshot: item as! DataSnapshot)
                
                if groceryItem?.field_tag == "Benefits" {
                    self.isFiltered = true
                    self.benefits.append(groceryItem!)
                } else if groceryItem?.field_tag == "Dispatch" {
                    self.isFiltered = true
                    self.dispatch.append(groceryItem!)
                } else if groceryItem?.field_tag == "Membership" {
                    self.isFiltered = true
                    self.membership.append(groceryItem!)
                } else if groceryItem?.field_tag == "Other Forms" {
                    self.isFiltered = true
                    self.otherForms.append(groceryItem!)
                } else if groceryItem?.field_tag == "Scholarships" {
                    self.isFiltered = true
                    self.scholarships.append(groceryItem!)
                } else if groceryItem?.field_tag == "Work Recovery" {
                    self.isFiltered = true
                    self.workRecovery.append(groceryItem!)
                } else if groceryItem?.field_tag == "Agent Reports" {
                    self.isFiltered = true
                    self.agentReports.append(groceryItem!)
                } else if groceryItem?.field_tag == "Business Manager Reports" {
                    self.isFiltered = true
                    self.businessMReports.append(groceryItem!)
                } else if groceryItem?.field_tag == "Connection Magazine" {
                    self.isFiltered = true
                    self.connectionMag.append(groceryItem!)
                } else if groceryItem?.field_tag == "Other Publications" {
                    self.isFiltered = true
                    self.otherPublications.append(groceryItem!)
                }else{
                    self.items.append(groceryItem!)
                    
                }
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
    

    // MARK: - Table view data source
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.section[section]
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            
            return benefits.count
            
        }
        else if section == 1{
            return dispatch.count
            //rowCount = enRoute.count
        }
        else if section == 2{
            return membership.count
        }
        else if section == 3{
            return otherForms.count
        }
        else if section == 4{
            return scholarships.count
        }
        else if section == 5{
            return workRecovery.count
            
        }
        else if section == 6{
            return agentReports.count
        }
        else if section == 7{
            return connectionMag.count
        }
        else if section == 8{
            return otherPublications.count
        }else {
            return items.count
        }
        
        
        
        
        
        
        
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resourceCell", for:indexPath)
       // var groceryItem = items[indexPath.row]
        if indexPath.section == 0 {
            var groceryItem = benefits[indexPath.row]
            let rawURL = "https://ua32.net\(groceryItem.field_document_file)"
            cell.textLabel?.text = groceryItem.name
            cell.detailTextLabel?.text = groceryItem.field_document_file
        }else if indexPath.section == 1{
            var groceryItem = dispatch[indexPath.row]
            let rawURL = "https://ua32.net\(groceryItem.field_document_file)"
            cell.textLabel?.text = groceryItem.name
            cell.detailTextLabel?.text = groceryItem.field_document_file
        }else if indexPath.section == 2{
            var groceryItem = membership[indexPath.row]
            let rawURL = "https://ua32.net\(groceryItem.field_document_file)"
            cell.textLabel?.text = groceryItem.name
            cell.detailTextLabel?.text = groceryItem.field_document_file
        }else if indexPath.section == 3{
            var groceryItem = otherForms[indexPath.row]
            let rawURL = "https://ua32.net\(groceryItem.field_document_file)"
            cell.textLabel?.text = groceryItem.name
            cell.detailTextLabel?.text = groceryItem.field_document_file
        }else if indexPath.section == 4{
            var groceryItem = scholarships[indexPath.row]
            let rawURL = "https://ua32.net\(groceryItem.field_document_file)"
            cell.textLabel?.text = groceryItem.name
            cell.detailTextLabel?.text = groceryItem.field_document_file
        }else if indexPath.section == 5{
            var groceryItem = workRecovery[indexPath.row]
            let rawURL = "https://ua32.net\(groceryItem.field_document_file)"
            cell.textLabel?.text = groceryItem.name
            cell.detailTextLabel?.text = groceryItem.field_document_file
        }else if indexPath.section == 6{
            var groceryItem = agentReports[indexPath.row]
            let rawURL = "https://ua32.net\(groceryItem.field_document_file)"
            cell.textLabel?.text = groceryItem.name
            cell.detailTextLabel?.text = groceryItem.field_document_file
        }else if indexPath.section == 7{
            var groceryItem = businessMReports[indexPath.row]
            let rawURL = "https://ua32.net\(groceryItem.field_document_file)"
            cell.textLabel?.text = groceryItem.name
            cell.detailTextLabel?.text = groceryItem.field_document_file
        }else if indexPath.section == 8{
            var groceryItem = connectionMag[indexPath.row]
            let rawURL = "https://ua32.net\(groceryItem.field_document_file)"
            cell.textLabel?.text = groceryItem.name
            cell.detailTextLabel?.text = groceryItem.field_document_file
        }else if indexPath.section == 9{
            var groceryItem = otherPublications[indexPath.row]
            let rawURL = "https://ua32.net\(groceryItem.field_document_file)"
            cell.textLabel?.text = groceryItem.name
            cell.detailTextLabel?.text = groceryItem.field_document_file
        }else{
            var groceryItem = items[indexPath.row]
        }
        
//        let rawURL = "https://ua32.net\(groceryItem.field_document_file)"
//
//        cell.textLabel?.text = groceryItem.name
//        cell.detailTextLabel?.text = groceryItem.field_document_file

        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        if indexPath.section == 0 {
            var groceryItem = benefits[indexPath.row]
             var valueToPass = groceryItem.field_document_file
        }else if indexPath.section == 1{
            var groceryItem = dispatch[indexPath.row]
            var valueToPass = groceryItem.field_document_file
        }else if indexPath.section == 2{
            var groceryItem = membership[indexPath.row]
            var valueToPass = groceryItem.field_document_file
        }else if indexPath.section == 3{
            var groceryItem = otherForms[indexPath.row]
            var valueToPass = groceryItem.field_document_file
        }else if indexPath.section == 4{
            var groceryItem = scholarships[indexPath.row]
            var valueToPass = groceryItem.field_document_file
        }else if indexPath.section == 5{
            var groceryItem = workRecovery[indexPath.row]
            var valueToPass = groceryItem.field_document_file
        }else if indexPath.section == 6{
            var groceryItem = agentReports[indexPath.row]
            var valueToPass = groceryItem.field_document_file
            
        }else if indexPath.section == 7{
            var groceryItem = businessMReports[indexPath.row]
            var valueToPass = groceryItem.field_document_file
        }else if indexPath.section == 8{
            var groceryItem = connectionMag[indexPath.row]
            var valueToPass = groceryItem.field_document_file
        }else if indexPath.section == 9{
            var groceryItem = otherPublications[indexPath.row]
            var valueToPass = groceryItem.field_document_file
        }else{
            var groceryItem = items[indexPath.row]
            var valueToPass = groceryItem.field_document_file
        }
        
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
