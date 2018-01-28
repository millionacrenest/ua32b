//
//  SeachViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 11/8/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit

class SeachViewController: UIViewController {

    @IBOutlet weak var searchWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL (string: "https://ua32.net/search_page/");
        let request = NSURLRequest(url: url! as URL);
        searchWebView.loadRequest(request as URLRequest);
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
