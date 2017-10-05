//
//  ContractorsTableViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 8/17/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase




class ContractorsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
 
    
    @IBOutlet weak var tableView: UITableView!
  
    
    let contractorsRef = Database.database().reference(withPath: "contractors")
    
    var itemsA: [Contacts] = []
    var itemsB: [Contacts] = []
    var itemsC: [Contacts] = []
    var itemsD: [Contacts] = []
    var itemsE: [Contacts] = []
    var itemsF: [Contacts] = []
    var itemsG: [Contacts] = []
    var itemsH: [Contacts] = []
    var itemsI: [Contacts] = []
    var itemsJ: [Contacts] = []
    var itemsK: [Contacts] = []
    var itemsL: [Contacts] = []
    var itemsM: [Contacts] = []
    var itemsALL: [Contacts] = []
    var sections = ["Concrete Cutters", "Firestop", "Gas", "Mechanical", "Pipeline", "Projects", "Public", "Refrigeration", "Shipyards", "School", "Tapping", "Wenatchee", "Other"]
    
    private var contractorCellExpanded : Bool = false
    var selectedIndexPath: IndexPath?
   
    var urlAsString: String!

    
    
    struct Objects {
        var sectionName: String!
        var sectionObjects: [String]!
        var expanded: Bool!
        
        init(sectionName: String, sectionObjects: [String], expanded: Bool) {
            self.sectionName = sectionName
            self.sectionObjects = sectionObjects
            self.expanded = expanded
        }
    }
    
    var objectsArray = [Objects]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // tableView.tableFooterView = UIView()
        
       
        
        fetchMechanical()
        fetchConcreteCutting()
        fetchFirestop()
        fetchGasDistribution()
        fetchPipeline()
        fetchProjects()
        fetchPublic()
        fetchRefrigeration()
        fetchSchool()
        fetchShipyards()
        fetchTapping()
        fetchWenatchee()
        fetchOther()
        fetchAll()
        self.tableView.reloadData()
       

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
//        self.tableView.bringSubviewToFront(vw)
    }

    // MARK: - Table view data source
    // MARK: - Table view data source
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = UIColor.red
        
        
        return vw
    }

    
 

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
       

        switch (section) {
        case 0:
            return itemsB.count
        case 1:
            return itemsC.count
        case 2:
            return itemsD.count
        case 3:
            return itemsA.count
        case 4:
            return itemsE.count
        case 5:
            return itemsF.count
        case 6:
            return itemsG.count
        case 7:
            return itemsH.count
        case 8:
            return itemsJ.count
        case 9:
            return itemsI.count
        case 10:
            return itemsK.count
        case 11:
            return itemsL.count
        case 12:
            return itemsM.count
        default:
            return itemsALL.count
        }
        
    
    }
    
    
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellContractors", for: indexPath) as! ContractorTableViewCell
     //   var items = [itemsB, itemsC, itemsD, itemsA, itemsE, itemsF, itemsG, itemsH, itemsJ, itemsI, itemsK, itemsL]

        
        switch (indexPath.section) {
        case 0:
        let item = itemsB[indexPath.row]
        cell.companyLabel.text = item.field_company
        cell.contactLabel.text = item.field_contact
        cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
        case 1:
            let item = itemsC[indexPath.row]
            cell.companyLabel.text = item.field_company
            cell.contactLabel.text = item.field_contact
            cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
        case 2:
            let item = itemsD[indexPath.row]
            cell.companyLabel.text = item.field_company
            cell.contactLabel.text = item.field_contact
            cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
        case 3:
            let item = itemsA[indexPath.row]
            cell.companyLabel.text = item.field_company
            cell.contactLabel.text = item.field_contact
            cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
        case 4:
            let item = itemsE[indexPath.row]
            cell.companyLabel.text = item.field_company
            cell.contactLabel.text = item.field_contact
            cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
        case 5:
            let item = itemsF[indexPath.row]
            cell.companyLabel.text = item.field_company
            cell.contactLabel.text = item.field_contact
            cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
        case 6:
            let item = itemsG[indexPath.row]
            cell.companyLabel.text = item.field_company
            cell.contactLabel.text = item.field_contact
            cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
        case 7:
            let item = itemsH[indexPath.row]
            cell.companyLabel.text = item.field_company
            cell.contactLabel.text = item.field_contact
            cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
        case 8:
            let item = itemsJ[indexPath.row]
            cell.companyLabel.text = item.field_company
            cell.contactLabel.text = item.field_contact
            cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
        case 9:
            let item = itemsI[indexPath.row]
            cell.companyLabel.text = item.field_company
            cell.contactLabel.text = item.field_contact
            cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
        case 10:
            let item = itemsK[indexPath.row]
            cell.companyLabel.text = item.field_company
            cell.contactLabel.text = item.field_contact
            cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
        case 11:
            let item = itemsL[indexPath.row]
            cell.companyLabel.text = item.field_company
            cell.contactLabel.text = item.field_contact
            cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
        case 12:
            let item = itemsM[indexPath.row]
            cell.companyLabel.text = item.field_company
            cell.contactLabel.text = item.field_contact
            cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
        default:
            let item = itemsA[indexPath.row]
            cell.companyLabel.text = item.field_company
            cell.contactLabel.text = item.field_contact
            cell.phoneNumberView.text = "\(item.field_phone!) \n\(item.field_address)"
            
        }
       

        return cell
    
    }
    
 
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let previousIndexPath = selectedIndexPath
        if indexPath == selectedIndexPath {
            selectedIndexPath = nil
        } else {
            selectedIndexPath = indexPath
        }
        var indexPaths : Array<IndexPath> = []
        if let previous = previousIndexPath {
            indexPaths += [previous]
        }
        if let current = selectedIndexPath {
            indexPaths += [current]
        }
        if indexPaths.count > 0 {
            tableView.reloadRows(at: indexPaths, with: .automatic)
        }
        
   
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as! ContractorTableViewCell).watchFrameChanges()
    }
   

 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == selectedIndexPath {
            return ContractorTableViewCell.expandedHeight
        } else {
            return ContractorTableViewCell.defaultHeight
        }
        
    }
    
    func fetchMechanical() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").queryEqual(toValue: "Mechanical").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
               
            }
            
            
            
            // 5
            self.itemsA = contractors
            self.tableView.reloadData()
          
            
        })
    }
    
    
    func fetchConcreteCutting() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").queryEqual(toValue: "Concrete Cutting").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
                
            }
            
            
            
            // 5
            self.itemsB = contractors
            self.tableView.reloadData()
         
            
        })
    }
    
    func fetchFirestop() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").queryEqual(toValue: "Firestop Specialists").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
                
            }
            
            
            
            // 5
            self.itemsC = contractors
            self.tableView.reloadData()
           
            
        })
    }
    
    func fetchGasDistribution() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").queryEqual(toValue: "Gas Distribution").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
                
            }
            
            
            
            // 5
            self.itemsD = contractors
            self.tableView.reloadData()
            
        })
    }
    
    func fetchPipeline() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").queryEqual(toValue: "Pipeline / Mainline").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
                
            }
            
            
            
            // 5
            self.itemsE = contractors
            self.tableView.reloadData()
           
            
        })
    }
    
    func fetchProjects() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").queryEqual(toValue: "Projects only").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
                
            }
            
            
            
            // 5
            self.itemsF = contractors
            self.tableView.reloadData()
            
        })
    }

    func fetchPublic() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").queryEqual(toValue: "Public Sector").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
                
            }
            
            
            
            // 5
            self.itemsG = contractors
            self.tableView.reloadData()
            
            
        })
    }
    
    func fetchRefrigeration() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").queryEqual(toValue: "Refrigeration / HVAC").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
                
            }
            
            
            
            // 5
            self.itemsH = contractors
            self.tableView.reloadData()
         
            
        })
    }
    
    func fetchSchool() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").queryEqual(toValue: "School Districts & Universities").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
                
            }
            
            
            
            // 5
            self.itemsI = contractors
            self.tableView.reloadData()
            
        })
    }
    
    
    func fetchShipyards() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").queryEqual(toValue: "Shipyards").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
                
            }
            
            
            
            // 5
            self.itemsJ = contractors
            self.tableView.reloadData()
           
            
        })
    }
    
    func fetchTapping() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").queryEqual(toValue: "Tapping Specialists").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
                
            }
            
            
            
            // 5
            self.itemsK = contractors
            self.tableView.reloadData()
            
        })
    }
    
    func fetchWenatchee() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").queryEqual(toValue: "Wenatchee & Peninsula Area").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
                
            }
            
            
            
            // 5
            self.itemsL = contractors
            self.tableView.reloadData()
            
            
        })
    }
    
    func fetchOther() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").queryEqual(toValue: "Other").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
                
            }
            
            
            
            // 5
            self.itemsM = contractors
            self.tableView.reloadData()
            
            
        })
    }
    
    func fetchAll() {
        
        contractorsRef.queryOrdered(byChild:"field_contractor_type").observe(.value, with: { snapshot in
            // 2
            var contractors: [Contacts] = []
            
            
            for item in snapshot.children {
                // 4
                let groceryItem = Contacts(snapshot: item as! DataSnapshot)
                contractors.append(groceryItem!)
                
            }
            
            
            
            // 5
            self.itemsALL = contractors
            self.tableView.reloadData()
            
            
        })
    }
    
    
    
   
    
    
    
}
