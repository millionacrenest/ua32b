//
//  ToolsViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 9/5/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ToolsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func updateUserSettingsTapped(_ sender: Any) {
        
        UIApplication.shared.openURL(NSURL(string: UIApplicationOpenSettingsURLString)! as URL)
        
    }
    
    
    
   
    @IBAction func logOutTapped(_ sender: Any) {
        do{
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "logoutSegue", sender: self)
        }catch{
            print("Error while signing out!")
        }
    }
    


}


