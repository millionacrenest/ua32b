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




class MapViewViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var imageUpoadingLabel: UILabel!

  
    @IBOutlet weak var locationName: UITextField!
    
    
    
    @IBOutlet weak var myImageView: UIImageView!
   
    
    @IBOutlet weak var coordinatesLabel: UILabel!
    
    @IBOutlet weak var tagsTextField: UITextField!
  
    @IBOutlet weak var scrollView: UIScrollView!
    
    let locationManager =  CLLocationManager()
     let newPin = MKPointAnnotation()
    var locationImageUrl = "" {
        didSet {
            print("it worked: \(locationImageUrl)")
        }
    }
    var longitude: Double = 0
    var latitude: Double = 0
    var ref = Database.database().reference()
    var refNodeLocations: DatabaseReference!
    var storage: Storage!
    var newMedia: Bool?
    let userID = Auth.auth().currentUser!.uid
    
    
    let picker = UIImagePickerController()
   
   
    var items: [NodeLocation] = []

    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
      //  scrollView.contentSize = CGSize(width: self.view.frame.size.width, height: 700)
        locationName.delegate = self
       // locationNotes.delegate = self
        tagsTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(MapViewViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
      
        
        picker.delegate = self
        
   //FirebaseApp.configure()
        refNodeLocations = Database.database().reference().child("nodeLocation")
        
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
                                               #selector(MapViewViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else if mediaType.isEqual(to: kUTTypeMovie as String) {
                // Code to support video here
            }
                    // Get a reference to the location where we'll store our photos
                    let photosRef = storage.reference().child("images")
            
                    // Get a reference to store the file at chat_photos/<FILENAME>
                    let filename = arc4random()
                    let photoRef = photosRef.child("images/\(filename).png")
            
                    // Upload file to Firebase Storage
                    let metadata = StorageMetadata()
                    metadata.contentType = "image/png"
                    photoRef.putData(imageData, metadata: metadata).observe(.success) { (snapshot) in
                        // When the image has successfully uploaded, we get it's download URL
                       
                        let text = snapshot.metadata?.downloadURL()?.absoluteString
            
                        // Set the download URL to the message box, so that the user can send it to the database
                        self.locationImageUrl = text!
                    }
            
            
        }
                myImageView.contentMode = .scaleAspectFit //3
                self.dismiss(animated: true, completion: nil)
        
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.locationName.resignFirstResponder()
       // self.locationNotes.resignFirstResponder()
        self.tagsTextField.resignFirstResponder()
        return true
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
        
        self.imageUpoadingLabel.text = "Uploading"
        
        picker.allowsEditing = false
        picker.sourceType = .photoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        picker.modalPresentationStyle = .popover
        present(picker, animated: true, completion: nil)
       
        
        
        
    }
   

    
    @IBAction func addLocationTapped(_ sender: Any) {
        
        //generating a new key inside artists node
        //and also getting the generated key
        let key = refNodeLocations.childByAutoId().key
        // Get a reference to the location where we'll store our photos
       //  let userID = UserDefaults.standard.value(forKey: "uid") as! String
      //  let usersRef = refNodeLocations.child(byAppendingPath: "users").child(byAppendingPath: userID)
    
      
       
        
        
        //creating artist with the given values
        let nodeLocation = ["id":key,
                      "locationName": locationName.text! as String,
                      "locationPhoto": locationImageUrl as String,
                      "locationTags": tagsTextField.text! as String,
                      "locationLatitude": latitude as Double,
                      "locationLongitude": longitude as Double,
                      "UID": "\(userID)"] as [String : Any]
        
     
        
        
        //adding the artist inside the generated unique key
        refNodeLocations.child(key).setValue(nodeLocation)
        
      
        
     
      
       
    }
    

  
}
