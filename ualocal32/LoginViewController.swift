//
//  LoginViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 6/13/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
  
    @IBOutlet weak var passwordTextField: UITextField!
    
   
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
         NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        
        Auth.auth().addStateDidChangeListener { auth, user in
            if user != nil {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePlateViewControllerMenu")
                self.present(vc!, animated: true, completion: nil)
                
                let uid = user?.uid
                print("the uid is \(uid)")
                
                
                let userID = Auth.auth().currentUser!.uid
                if Messaging.messaging().fcmToken != nil {
                    Messaging.messaging().subscribe(toTopic: "/topics/\(userID)")
                    Messaging.messaging().subscribe(toTopic: "/topics/all")
                    
                    print("topic created did register notification settings")
                }
            }
                
                
            else {
                
                
                //handle error
                
                
            }
        }
        
        
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        

    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
 
  
    @IBAction func loginButtonTapped(_ sender: Any) {
        
    
        
        if self.emailTextField.text == "" || self.passwordTextField.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
           
            
        } else {
            
            Auth.auth().signIn(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomePlateViewControllerMenu")
                    self.present(vc!, animated: true, completion: nil)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                    
//                    //Go to the HomeViewController if the login is sucessful
//                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignUp")
//                    self.present(vc!, animated: true, completion: nil)
                }
            }
        }
        

        
        
    }
    
  
}
