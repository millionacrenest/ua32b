//
//  MapViewViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 6/14/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase
import FirebaseDatabase
import MobileCoreServices
import Alamofire
import MessageUI


class AddPinViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var locationName: UITextField!

    @IBOutlet weak var myImageView: UIImageView!

    @IBOutlet weak var agentPickerView: UIPickerView!

    @IBOutlet weak var notesTextField: UITextField!
    let locationManager =  CLLocationManager()
    let newPin = MKPointAnnotation()
    var locationImageUrl: String?
    var longitude: Double = 0
    var latitude: Double = 0
    var ref = Database.database().reference()
    var refNodeLocations: DatabaseReference!
    var agentRef: DatabaseReference!
    var storage: Storage!
    var newMedia: Bool?
    let userID = Auth.auth().currentUser!.uid
   
    var agentID: String?
    var pickedUID: String?
    var picked1: String?
    var email: String?

   // var items: [NodeLocation] = []
   

    
    var organzier: [Staff] = []
    var agents: [Staff] = []
    
    
    var picked: String?
    let picker = UIImagePickerController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        getAgents()
       
        // scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 700)
        locationName.delegate = self
        // locationNotes.delegate = self
        //  tagsTextField.delegate = self

        
        picker.delegate = self
        
        myImageView.clipsToBounds = true
        myImageView.translatesAutoresizingMaskIntoConstraints = false
        
        if !MFMailComposeViewController.canSendMail() {
            print("Mail services are not available")
            return
        }
        
        //FirebaseApp.configure()
        refNodeLocations = Database.database().reference().child("nodeLocation")
        agentRef = Database.database().reference().child("taggable")
        
        storage = Storage.storage()
        
        // User's location
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            locationManager.requestAlwaysAuthorization()
        } else {
            // Fallback on earlier versions
        }
        locationManager.startUpdatingLocation()
        self.agentPickerView.delegate = self
        self.agentPickerView.dataSource = self
        self.agentPickerView.selectRow(0, inComponent: 0, animated: true)
        self.agentPickerView.reloadAllComponents()
        
        print("\(agents.first?.key)")
       
     
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

    

   
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return agents.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        let titleData = agents[row].field_full_name
       
        return titleData
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.picked = agents[row].key
        self.pickedUID = agents[row].field_uid
        self.email = agents[row].field_email
       
    }
    
    
    
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //mapView.removeAnnotation(newPin)
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        var locValue:CLLocationCoordinate2D = locationManager.location!.coordinate
        //print("locations = \(locValue.latitude) \(locValue.longitude)")
        latitude = locValue.latitude
        longitude = locValue.longitude
        
    }
    
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            let imageData = UIImageJPEGRepresentation(image, 0.3)!
            
            myImageView.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               #selector(AddPinViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else if mediaType.isEqual(to: kUTTypeMovie as String) {
                // Code to support video here
            }
            
            
        }
        //myImageView.contentMode = .scaleAspectFit //3
        self.dismiss(animated: true, completion: nil)
        saveImage()
        
        
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
    
    func saveImage() {
        // Get a reference to the location where we'll store our photos
        let photosRef = storage.reference().child("images")
        
        // Get a reference to store the file at chat_photos/<FILENAME>
        let filename = arc4random()
        let photoRef = photosRef.child("\(filename).png")
        
        // Upload file to Firebase Storage
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        let imageData = UIImageJPEGRepresentation(myImageView.image!, 0.3)!
        photoRef.putData(imageData, metadata: metadata).observe(.success) { (snapshot) in
            // When the image has successfully uploaded, we get it's download URL
            // self.imageUpoadingLabel.text = "Upload complete"
            
            let text = snapshot.metadata?.downloadURL()?.absoluteString
            
            // Set the download URL to the message box, so that the user can send it to the database
            self.locationImageUrl = text!
        }
    }

    
    @IBAction func saveButtonTapped(_ sender: Any) {
        
        if locationImageUrl != nil {
        let key = refNodeLocations.childByAutoId().key
            
                
                let pickedAgent = agentRef.child("\(picked!)")
                //creating artist with the given values
                let nodeLocation = ["locationName": locationName.text! as String,
                                    "locationLatitude": latitude as Double,
                                    "locationLongitude": longitude as Double,
                                    "locationPhoto": locationImageUrl,
                                    "locationNotes": notesTextField.text,
                    "UID": "\(userID)",
                    "field_tag": "\(pickedUID)"
                    ] as [String : Any]
                refNodeLocations.child(key).setValue(nodeLocation)
                pickedAgent.child(key).setValue(nodeLocation)
                postMessage()
                sendEmail()
            

        //message this topic: pickedUID

        let alertController = UIAlertController(title: "Success!", message: "Your report has been sent to the Agent.", preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(defaultAction)

        self.present(alertController, animated: true, completion: nil)
       
        } else {
            let alertController = UIAlertController(title: "Error", message: "Your report does not include an image or the image is taking too long to load. Please check your connection and try again.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
            
        }
    }

    func getAgents(){
        
        agentRef = Database.database().reference().child("taggable")
        let query = agentRef.queryOrdered(byChild: "field_type")

        query.observe(.value, with: { snapshot in
            // 2
            var frontpages: [Staff] = []

            for item in snapshot.children {
                // 4
                let groceryItem = Staff(snapshot: item as! DataSnapshot)
                frontpages.append(groceryItem!)
                
            }

            // 5
            self.agents = frontpages
            self.agentPickerView.reloadAllComponents()
        })

    }
    
    
    
    
    func sendEmail() {
        
        
        if MFMailComposeViewController.canSendMail() {
            
            
        
        
        var mapLink = "http://www.google.com/maps/place/\(latitude),\(longitude)"
        
       
        var body = "<html><body><h3>\(locationName.text!)</h3><br><a href=\(mapLink)>Open in Google Maps</a><p>\(notesTextField.text!)</p><br><img src='\(locationImageUrl!)' width='100%'></body></html>"
        
  
        print("email is is: \(email)")
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        // Configure the fields of the interface.
        composeVC.setToRecipients([email!])
        composeVC.setSubject("You've been tagged on the UA 32 Map!")
        composeVC.setMessageBody("\(body)", isHTML: true)
        // Present the view controller modally.
        
        self.present(composeVC, animated: true, completion: nil)
            
            
        } else {
            let alertController = UIAlertController(title: "Error", message: "You must enable mail on your phone to send message.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
 
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
        func postMessage(){
            
   
        
        //requestString variable must be of type [String]
        let requestString : String =  "https://fcm.googleapis.com/fcm/send"
        
        //headers variable must be of type [String: String]
        let headers: [String: String] = [
            "Authorization": "key=399143312974",
            "Content-Type": "application/json"
        ]
            
            let params: Parameters = [
                "to": "/topics/\(pickedUID!)",
                "body": "you've been tagged - test message"
            ]
        
        //parameters variable must be of type [String : Any]
//        let params : [String : Any] = [
//            "to" : "/topics/\(pickedUID!)",
//            "priority" : "high"
//        ]
        print("params: \(params)")
        Alamofire.request(
            URL(string: requestString)!,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default,
            headers:headers)
           // .validate()
            .responseString { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(response.result.error!)")
                    
                    return
                }
   
        }
     
    }

}

