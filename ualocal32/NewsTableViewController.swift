////
////  NewsTableViewController.swift
////  ualocal32
////
////  Created by Allison Mcentire on 8/14/17.
////  Copyright © 2017 Allison Mcentire. All rights reserved.
////
//
//import UIKit
//import Firebase
//import FirebaseDatabase
//
//
//class NewsTableViewController: UITableViewController {
//    
//    let contractorsRef = Database.database().reference(withPath: "contractors")
//     var items: [Contractors] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        
//        // 1
//        contractorsRef.observe(.value, with: { snapshot in
//            // 2
//            var contractors: [Contractors] = []
//           
//            for item in snapshot.children {
//                // 4
//                let groceryItem = Contractors(snapshot: item as! DataSnapshot)
//                contractors.append(groceryItem!)
//            }
//            
//            // 5
//            self.items = contractors
//            self.tableView.reloadData()
//            
//        })
//
//   
//        
//    }
//    
//        
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    
//    
//    
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return items.count
//    }
//
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath as IndexPath)
//        let groceryItem = items[indexPath.row]
//        
//        cell.textLabel?.text = groceryItem.field_company
//        cell.detailTextLabel?.text = groceryItem.field_phone
//     
//        
//        return cell
//        }
//    
//        
//    
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//    
//    
//    
//    
//    
//
//}
