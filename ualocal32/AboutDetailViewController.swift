//
//  AboutDetailViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 9/3/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage

class AboutDetailViewController: UIViewController {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
   
    
  
    
  
    
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    
    
    
    let aboutRef = Database.database().reference(withPath: "events")
    var passedValue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        aboutRef.child(passedValue).observeSingleEvent(of: .value, with: {
            (snapshot:DataSnapshot!) in
            
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.titleLabel.text = value?["title"] as? String ?? ""
            self.bodyTextView.text = value?["body"] as? String ?? ""
            
            
          
            
            
            
            
        })
        
        
        
        
    }
    
    
    
}
