//
//  FacebookViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 11/8/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit

class FacebookViewController: UIViewController {
    
    @IBOutlet weak var facebookView: UIWebView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let url = NSURL (string: "https://www.facebook.com/Local32/");
        let request = NSURLRequest(url: url! as URL);
        facebookView.loadRequest(request as URLRequest);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
