//
//  PDFReadViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 8/25/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit

class PDFReadViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    var passedValue: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let url = URL(string: "https://ua32.net\(passedValue!)")
        
        
        
        webView.loadRequest(URLRequest(url: url!))

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func shareButton(_ sender: Any) {
        
      
        
        // set up activity view controller
        let textToShare = passedValue as Any
        let activityViewController = UIActivityViewController(activityItems: [textToShare], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivityType.airDrop, UIActivityType.postToFacebook ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
        
        
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
