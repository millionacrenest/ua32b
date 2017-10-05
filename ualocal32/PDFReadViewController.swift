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
        
        
        
        let url = URL(string: "http://ua32.net\(passedValue!)")
        
        
        
        webView.loadRequest(URLRequest(url: url!))

        // Do any additional setup after loading the view.
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
