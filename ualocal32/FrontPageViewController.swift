//
//  FrontPageViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 8/18/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage
import AVFoundation


class FrontPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
   
    let frontpageRef = Database.database().reference(withPath: "website")
    var storage: Storage!

    var items: [Website] = []
   
    private var frontpageCellExpanded : Bool = false
    var selectedIndexPath: IndexPath?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = Storage.storage()
        tableView.tableFooterView = UIView()
        
        frontpageRef.observe(.value, with: { snapshot in
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
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "frontPageCell", for: indexPath) as! FrontPageTableViewCell
        
        
        
        let groceryItem = items[indexPath.row]
        //let image = groceryItem.field_image
        
       
       // var url = URL(string: groceryItem.field_image!)

        let str = groceryItem.body?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        
       
        cell.titleLabel.text = groceryItem.title
        cell.bodyTextView.text = str
        cell.tagLabel.text = groceryItem.term_node_tid
        cell.frontpageImage.sd_setImage(with: URL(string: groceryItem.field_image!))
//        let videoString = groceryItem.field_media_video_embed_field
//        let videoURL = NSURL(string: videoString!)
//        
//        let player = AVPlayer(url: videoURL! as URL)
//        let playerLayer = AVPlayerLayer(player: player)
//        
//        playerLayer.frame = cell.bounds
//        cell.layer.addSublayer(playerLayer)
//        player.play()
       
      
        return cell
        
       
        
    }
    
  
    
 
    
    
  
    
   

  
    



}
