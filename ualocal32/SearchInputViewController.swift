//
//  SearchInputViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 1/15/18.
//  Copyright © 2018 Allison Mcentire. All rights reserved.
//

import UIKit

class SearchInputViewController: UIViewController {

    
    
    @IBOutlet weak var searchInputView: UITextField!
   
    
    @IBOutlet weak var searchInputWebView: UIWebView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
       
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        let input = searchInputView.text!
        let url = NSURL (string: "https://ua32.net/search_page/\(input)");
        let request = NSURLRequest(url: url! as URL);
        searchInputWebView.loadRequest(request as URLRequest);
        
        searchInputView.resignFirstResponder()
        
        
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
