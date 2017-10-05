//
//  MenuViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 8/23/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    @IBOutlet weak var viewView: UIView!
    
    @IBOutlet weak var leadingContraint: NSLayoutConstraint!
    
    @IBOutlet weak var trailingConstraint: NSLayoutConstraint!
    
    var menuIsVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    
    @IBAction func menuButtonTapped(_ sender: Any) {
        
        if !menuIsVisible {
            leadingContraint.constant = 150
            trailingConstraint.constant = -150
            
            menuIsVisible = true
        } else {
            leadingContraint.constant = 0
            trailingConstraint.constant = 0
            
            menuIsVisible = false
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: .curveEaseIn, animations: {
            self.view.layoutIfNeeded()
        }) { (animationComplete) in
            print("complete")
        }
        
        
    }
    
    
    
    @IBAction func buttonTapped(_ sender: Any) {
        
        
    }
 


}

