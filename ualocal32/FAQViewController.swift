//
//  FAQViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 9/5/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class FAQViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var questionTextField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
   let faqRef = Database.database().reference(withPath: "faq")
    let userID = Auth.auth().currentUser!.uid
    var items: [FAQ] = []
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        faqRef.observe(.value, with: { (snapshot) in
            
            
            // 2
            var frontpages: [FAQ] = []
            
            for item in snapshot.children {
                // 4
                let groceryItem = FAQ(snapshot: item as! DataSnapshot)
                frontpages.append(groceryItem!)
            }
            
            
            // 5
            self.items = frontpages
            
            self.tableView.reloadData()
            
            
            
            
            
            
        })
        
        
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
        tableView.reloadData()
        
   
    }

    
    func postQuestion(){
        
        
        
        
        let question = questionTextField.text!
        let body = ""
        
        
        
        
        let key = faqRef.childByAutoId().key
        
        //creating artist with the given values
        let faq = ["question": questionTextField.text! as String,
                            "answer": questionTextField.text! as String,
                            "UID": "\(userID)"] as [String : Any]
        
        
        
        
        //adding the artist inside the generated unique key
        faqRef.child(key).setValue(faq)
        
    
    }
   
    @IBAction func saveTapped(_ sender: Any) {
        
        postQuestion()
        
        let alertController = UIAlertController(title: "Thank you!", message: "Your question will be answered as soon as possible", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "Dismiss", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "faqCell", for: indexPath as IndexPath) as! FAQTableViewCell
        
        let faq = items[indexPath.row]
        cell.questionLabel.text = faq.question
        cell.answerTextView.text = faq.answer

        
        return cell
    }
    
 
    
   
    
    
    

}
