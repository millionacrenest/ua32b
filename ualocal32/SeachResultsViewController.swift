//
//  SeachResultsViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 9/4/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage

class SeachResultsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    
    @IBOutlet weak var bodyTextView: UITextView!

    
    
    
    let searchRef = Database.database().reference(withPath: "website")
    var passedValue: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        searchRef.child(passedValue).observeSingleEvent(of: .value, with: {
            (snapshot:DataSnapshot!) in
            
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.titleLabel.text = value?["title"] as? String ?? ""
            self.tagLabel.text = value?["field_tag"] as? String ?? ""
            self.bodyTextView.text = value?["body"] as? String ?? ""
            var imageString = value?["field_image"] as? String ?? ""
            
            
            
            
            self.imageView?.sd_setImage(with: URL(string: imageString), placeholderImage: UIImage(named: "https://cdn.pixabay.com/photo/2017/08/12/00/17/like-2633137_1280.png"))
            
            
        })
    }



}
