//
//  CommentPostViewController.swift
//  buildingTrades
//
//  Created by Allison Mcentire on 8/27/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import MobileCoreServices

class CommentPostViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentImageView: UIImageView!
    
    @IBOutlet weak var commentBodyView: UITextView!
    
    let userID = Auth.auth().currentUser!.uid
    var commentArray: [String] = [String]()
    var userArray: [String] = [String]()
    var ref = Database.database().reference()
    var varToReceive: String!
    var newMedia: Bool!
    var commentImageURL: String!
    var storage: Storage!
    
    
    let picker = UIImagePickerController()
    
    var lastPoint = CGPoint.zero
    var red: CGFloat = 247.0
    var green: CGFloat = 239.0
    var blue: CGFloat = 91.0
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = Storage.storage()
      
       // var commentsRef = Database.database().reference().child("contacts")
        
        
        picker.delegate = self
        
       NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
   
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
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            let imageData = UIImageJPEGRepresentation(image, 0.3)!
            
            commentImageView.image = image
           
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               #selector(CommentPostViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
                
            } else if mediaType.isEqual(to: kUTTypeMovie as String) {
                // Code to support video here
            }
            
            
        }
        //myImageView.contentMode = .scaleAspectFit //3
        self.dismiss(animated: true, completion: nil)
        photoTaken()
        
        
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

    
    func photoTaken() {
        // Get a reference to the location where we'll store our photos
        let photosRef = storage.reference().child("images")
        
        // Get a reference to store the file at chat_photos/<FILENAME>
        let filename = arc4random()
        let photoRef = photosRef.child("\(filename).png")
        
        // Upload file to Firebase Storage
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        let imageData = UIImageJPEGRepresentation(commentImageView.image!, 0.3)!
        photoRef.putData(imageData, metadata: metadata).observe(.success) { (snapshot) in
            // When the image has successfully uploaded, we get it's download URL
            // self.imageUpoadingLabel.text = "Upload complete"
            // self.uploadComplete = true
            let text = snapshot.metadata?.downloadURL()?.absoluteString
            
            // Set the download URL to the message box, so that the user can send it to the database
            self.commentImageURL = text!
    
        }
    }
    
    func postComment(){
        
        let locationsRef = ref.child("nodeLocation")
        
        let thisLocationRef = locationsRef.child(varToReceive)
        
        let thisUserPostRef = thisLocationRef.child("comments")
        let thisCommentPostRef = thisUserPostRef.childByAutoId //create a new post node
        
        
        let body = commentBodyView.text!
        let image = commentImageURL as String?
        let date = "today"
        
        let newComment = ["body": body, "image": image, "date": date, "UID": userID] as [String : Any]
        
        
        thisCommentPostRef().setValue(newComment)
    }

    
    @IBAction func saveTapped(_ sender: Any) {
        
       if commentImageURL != nil {
            postComment()
            let alertController = UIAlertController(title: "Success!", message: "Your comment has been posted.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            
            self.present(alertController, animated: true, completion: nil)
            //Go to the HomeViewController if the login is sucessful
         
        } else {
            
            let alertController = UIAlertController(title: "Error", message: "Your comment does not include an image or your image is taking too long to load. Please try again.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    
        
     
        
    }
    
    
    @IBAction func cameraButton(_ sender: Any) {
        
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
    

    
    
}
