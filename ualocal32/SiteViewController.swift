//
//  SiteDetailViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 7/13/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import FirebaseDatabase
import MobileCoreServices
import SDWebImage

class SiteViewController: UIViewController, MKMapViewDelegate, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var siteImage: UIImageView?
    @IBOutlet weak var locationNameTextField: UILabel!
    
   
    @IBOutlet weak var locationNotesTextView: UITextView!
    
    @IBOutlet weak var tableView: UITableView!
    
    let userID = Auth.auth().currentUser!.uid
    var items: [Comments] = []
    
    
    
    
    
    
    var varToReceive = ""
    var ref = Database.database().reference()
    
    var updatedName = ""
    var commentArray: [String] = [String]()
    var userArray: [String] = [String]()
    var updatedTag = ""
    var updatedLocationImageUrl = ""
    
    let cellIdentifier = "commentCell"
    var storage: Storage!
    var newMedia: Bool?
    
    let picker = UIImagePickerController()

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        //        locationNameTextField.delegate = self
        //        addCommentsTextField.delegate = self
        //        locationTagsTextField.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 250
        
        
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(SiteViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SiteViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let nodesRef = ref.child("nodeLocation")
        let queryRef = nodesRef.queryOrderedByKey().queryEqual(toValue: varToReceive)
        let commentRef = nodesRef.child(varToReceive).child("comments")
        
        storage = Storage.storage()
        
        queryRef.observeSingleEvent(of: .value, with: { (snapshot) in
            
            for snap in snapshot.children {
                guard let nodeSnap = snap as? DataSnapshot else { continue }
              //  let id = nodeSnap.key
                guard let nodeDict = nodeSnap.value as? [String:AnyObject]  else { continue }
                let name = nodeDict["locationName"] as? String
                
                
                let notes = nodeDict["locationNotes"] as? String
                let imageString = nodeDict["locationPhoto"] as? String
                
                self.locationNameTextField.text = name
                
                self.locationNotesTextView.text = notes
                
                self.siteImage?.sd_setImage(with: URL(string: imageString!), placeholderImage: UIImage(named: "https://cdn.pixabay.com/photo/2017/08/12/00/17/like-2633137_1280.png"))
                
            }
            
        })
        
        
        commentRef.observe(.value, with: { (snapshot) in
            
            
            // 2
            var frontpages: [Comments] = []
            
            for item in snapshot.children {
                // 4
                let groceryItem = Comments(snapshot: item as! DataSnapshot)
                frontpages.append(groceryItem)
            }
            
            
            // 5
            self.items = frontpages
            self.tableView.reloadData()
            
            
            
            
            
            
        })
        
        
        
        
        
        tableView.reloadData()
        
        
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //        self.locationNameTextField.resignFirstResponder()
        //        self.addCommentsTextField.resignFirstResponder()
        //        self.locationTagsTextField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func addCommentsTapped(_ sender: Any) {
        
        performSegue(withIdentifier: "commentDetail", sender: self)
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "commentDetail" {
            if let toViewController = segue.destination as? CommentPostViewController {
                toViewController.varToReceive = varToReceive
            }
        }
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath as IndexPath) as! SiteCommentsTableViewCell
        
        let comment = items[indexPath.row]
        cell.bodyView?.text = comment.body
        
//        cell.dateCreatedLabel?.text = comment.dateCreated
        
        if comment.image == nil {
            var imageString = "https://cdn.pixabay.com/photo/2017/08/12/00/17/like-2633137_1280.png"
             cell.commentImageView?.sd_setImage(with: URL(string: imageString), placeholderImage: UIImage(named: "https://cdn.pixabay.com/photo/2017/08/12/00/17/like-2633137_1280.png"))
        } else {
            var imageString = comment.image
             cell.commentImageView?.sd_setImage(with: URL(string: imageString!), placeholderImage: UIImage(named: "https://cdn.pixabay.com/photo/2017/08/12/00/17/like-2633137_1280.png"))
        }
        
       
        
   

        
        
       
        
        return cell
    }
    

    
    
    
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafeRawPointer) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "OK",
                                             style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true,
                         completion: nil)
        }
    }
    
    
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    @IBAction func useCamera(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType =
                UIImagePickerControllerSourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true,
                         completion: nil)
            newMedia = true
        }
    }
    
    
    
    
    
    @IBAction func photoLibraryButton(_ sender: Any) {
        
        
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
        
        
        
        
    }
    

    
    
}


