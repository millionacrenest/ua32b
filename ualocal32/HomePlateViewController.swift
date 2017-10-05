//
//  HomePlateViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 9/2/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit

class HomePlateViewController: UIViewController {
    
    
   
    
    var menu_vc: MenuTooViewController!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        menu_vc = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuTooViewController
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToGesture))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        
        self.view.addGestureRecognizer(swipeRight)
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @IBAction func menu_action(_ sender: UIBarButtonItem) {
        
        if AppDelegate.menu_bool == true {
            showMenu()
        } else {
            closeMenu()
        }
        
        
    }
    
    func close_on_swipe() {
        
        if AppDelegate.menu_bool == true {
           // showMenu()
        } else {
            closeMenu()
        }
        
    }
    
    func respondToGesture(gesture: UISwipeGestureRecognizer)
    {
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            print("right swipe")
        case UISwipeGestureRecognizerDirection.left:
            print("left swipe")
            close_on_swipe()
        default:
            break
        }
        
        
    }
    func showMenu() {
        UIView.animate(withDuration: 0.3) { () ->Void in
            self.menu_vc.view.frame = CGRect(x: 0, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.menu_vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
            self.addChildViewController(self.menu_vc)
            self.view.addSubview(self.menu_vc.view)
            AppDelegate.menu_bool = false
            
        }

    }
    
    func closeMenu() {
        UIView.animate(withDuration: 0.3, animations: { () ->Void in
            self.menu_vc.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        }) { (finished) in
            self.menu_vc.view.removeFromSuperview()
        }
        
        AppDelegate.menu_bool = true
        
    }

  
        
        
        

}
