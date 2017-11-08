//
//  WebsiteViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 11/8/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class WebsiteViewController: UIViewController {

    @IBOutlet weak var websiteWebView: UIWebView!
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = NSURL (string: "https://www.ua32.net");
        let request = NSURLRequest(url: url! as URL);
        websiteWebView.loadRequest(request as URLRequest);
    }

   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
