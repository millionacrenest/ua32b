//
//  StaffDetailViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 9/3/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import SDWebImage

class StaffDetailViewController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var profilePictureView: UIImageView!
    
    
    @IBOutlet weak var tagLabel: UILabel!

    @IBOutlet weak var bodyTextView: UITextView!
    
    let staffRef = Database.database().reference(withPath: "staff")
    var passedValue: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        

        
        staffRef.child(passedValue).observeSingleEvent(of: .value, with: {
            (snapshot:DataSnapshot!) in
            
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.nameLabel.text = value?["field_full_name"] as? String ?? ""
            self.tagLabel.text = value?["field_tag"] as? String ?? ""
            var field_local_32_member_since = value?["field_local_32_member_since"] as? String ?? ""
            var field_on_staff_since = value?["field_on_staff_since"] as? String ?? ""
            var field_email = value?["field_email"] as? String ?? ""
            var imageString = value?["field_profile_picture"] as? String ?? ""
            
            self.bodyTextView.text = "Local 32 Member since: \(field_local_32_member_since) \nOn Staff since: \(field_on_staff_since) \n\(field_email)"
          
       
            
            self.profilePictureView?.sd_setImage(with: URL(string: imageString), placeholderImage: UIImage(named: "https://cdn.pixabay.com/photo/2017/08/12/00/17/like-2633137_1280.png"))
            
            
            
            
        })
     
    }



}
