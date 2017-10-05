//
//  AddContactsViewController.swift
//  ua32.net
//
//  Created by Allison Mcentire on 8/28/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddContactsViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    @IBOutlet weak var contactNameLabel: UITextField!
    
    @IBOutlet weak var contactCompanyLabel: UITextField!
    
    @IBOutlet weak var contactTelephoneLabel: UITextField!
    
    
    @IBOutlet weak var contactAddressLabel: UITextField!
    
    @IBOutlet weak var contactCityLabel: UITextField!
    
    
    @IBOutlet weak var contactStateLabel: UITextField!
    
    
    
    @IBOutlet weak var contactZipLabel: UITextField!
    
    @IBOutlet weak var contactEmailField: UITextField!
    
    
    @IBOutlet weak var contactWebsiteField: UITextField!
    
    
    @IBOutlet weak var contactTypePicker: UIPickerView!
    var items: [Contacts] = []
    var pickerData = ["Concrete Cutters", "Firestop", "Gas", "Mechanical", "Pipeline", "Projects", "Public", "Refrigeration", "Shipyards", "School", "Tapping", "Wenatchee", "Other"]
    var picked: String!
   
    
    var refContacts = Database.database().reference().child("contractors")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(AddContactsViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddContactsViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        contactNameLabel.delegate = self
        contactCompanyLabel.delegate = self
        contactTelephoneLabel.delegate = self
        contactAddressLabel.delegate = self
        contactCityLabel.delegate = self
        contactStateLabel.delegate = self
        contactZipLabel.delegate = self
        contactEmailField.delegate = self
        contactWebsiteField.delegate = self
        
        // Connect data:
        self.contactTypePicker.delegate = self
        self.contactTypePicker.dataSource = self
        
        
        
        // Do any additional setup after loading the view.
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return pickerData.count
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView!, titleForRow row: Int, forComponent component: Int) -> String! {
        let titleData = pickerData[row]
        
        return titleData
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.picked = pickerData[row]
    
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.contactNameLabel.resignFirstResponder()
        self.contactCompanyLabel.resignFirstResponder()
        self.contactTelephoneLabel.resignFirstResponder()
        self.contactAddressLabel.resignFirstResponder()
        self.contactCityLabel.resignFirstResponder()
        self.contactStateLabel.resignFirstResponder()
        self.contactZipLabel.resignFirstResponder()
        self.contactEmailField.resignFirstResponder()
        self.contactWebsiteField.resignFirstResponder()
        
        
        return true
    }
    
    @IBAction func saveContactTapped(_ sender: Any) {
        
      
        let key = refContacts.childByAutoId().key
        
        //creating artist with the given values
        let contact = ["field_contact": contactNameLabel.text! as String,
                       "field_contractor_type": "\(picked!)",
            "field_phone": contactTelephoneLabel.text! as String,
            "field_address": contactAddressLabel.text! as String,
            "field_company": contactCompanyLabel.text! as String,
            "field_website": contactWebsiteField.text! as String,
            "field_email": contactEmailField.text! as String,
            "field_city": contactCityLabel.text! as String,
            "field_state": contactStateLabel.text! as String,
            "field_zip": contactZipLabel.text! as String]
        
        
        
        
        //adding the artist inside the generated unique key
        refContacts.child(key).setValue(contact)
        
        
        
    }
    
    
}
