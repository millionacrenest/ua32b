//
//  WebPostViewController.swift
//  ualocal32
//
//  Created by Allison Mcentire on 9/1/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import MobileCoreServices
import Alamofire




class WebPostViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var tagLevelOnePicker: UIPickerView!
    
    @IBOutlet weak var titleLabel: UITextField!
    
    @IBOutlet weak var bodyTextField: UITextField!
    
    
    @IBOutlet weak var webImageView: UIImageView!
    var items: [Website] = []
    var imageWebsiteURL: String!
    var varToReceive: String!
    var newMedia: Bool!

    var storage: Storage!
    
    var refWebPost = Database.database().reference().child("webPost")
    
    var pickerData = ["<<About>>", "Jurisdiction Map", "Partnerships", "<<Home>>", "Events", "News", "Videos", "Banner", "<<Political>>", "Endorsements", "PAC Documents", "PAC Gallery", "PAC News & Events", "PAC Resources", "PAC Videos", "<<Resources>>", "<<Forms>>", "Benefits", "Dispatch", "Membership", "Other Forms", "Scholarships", "Work Recovery", "Links", "<<Publications>>", "Agent Reports", "Business Manager Reports", "Connections Magazine", "Other Publications", "<<Retirees>>", "Retiree Gallery", "Retiree Resources", "Retiree Videos"]
  
    var picked: String!
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storage = Storage.storage()

        titleLabel.delegate = self
        bodyTextField.delegate = self
        
        picker.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(WebPostViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(WebPostViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

       
        fetchAllRooms()
        
        
      
       
    }
    
    
//    curl --include --request POST --user webmaster:F1ghtTheP0wer! --header 'Content-type: application/hal+json' http://ua32.net/entity/node?_format=hal+json --data-binary '{"_links":{"type":{"href":"http://ua32.net/rest/type/node/page"}}, "title":[{"value":"My second page"}], "body":[{"value":"lorem"}]}'

    func fetchAllRooms() {
        
        
        let user = "webmaster"
        let password = "F1ghtTheP0wer!"
        let credentialData = "\(user):\(password)".data(using: String.Encoding.utf8)!
        let base64Credentials = credentialData.base64EncodedString(options: [])
         let headers = ["Content-Type" : "application/hal+json", "Accept" : "application/hal+json", "Authorization": "Basic \(base64Credentials)"]
        
     
        var dataDict : [String : Any] = [:]
        dataDict["_links"] = ["type": ["href":"http://ua32.net/rest/type/node/page"]]
        dataDict["title"] = ["value":"My second page"]
        dataDict["body"] = ["value":"My second page lorem"]
        let params: [String:Any] = ["_links": ["type": ["href":"http://ua32.net/rest/type/node/page"]], "title":["value":"My third page"], "body":["value":"My second page lorem rocks"], "type": ["target_id":"page"]]
        
//        
//        var jsonObject: NSData? = nil
//        
//        do {
//            jsonObject = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions()) as NSData
//            print("json:\(jsonObject)") // This will print the below json.
//        } 
//        catch{}
        
        
        Alamofire.request(
            URL(string: "http://ua32.net/entity/node?_format=hal+json")!,
            method: .post,
            parameters: params,
            encoding: JSONEncoding.default,
            headers:headers)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(response.result.error)")
                   
                    return
                }
               
                
                
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.titleLabel.resignFirstResponder()
        self.bodyTextField.resignFirstResponder()
        //        self.locationTagsTextField.resignFirstResponder()
        return true
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            let imageData = UIImageJPEGRepresentation(image, 0.3)!
            
            webImageView.image = image
            
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                                               #selector(WebPostViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
                
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
        let imageData = UIImageJPEGRepresentation(webImageView.image!, 0.3)!
        photoRef.putData(imageData, metadata: metadata).observe(.success) { (snapshot) in
            // When the image has successfully uploaded, we get it's download URL
            // self.imageUpoadingLabel.text = "Upload complete"
            // self.uploadComplete = true
            let text = snapshot.metadata?.downloadURL()?.absoluteString
            
            // Set the download URL to the message box, so that the user can send it to the database
            self.imageWebsiteURL = text!
            
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let titleData = pickerData[row]
        
        return titleData
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.picked = pickerData[row]
    }
    
    func saveWebPost() {
        let key = refWebPost.childByAutoId().key
        
        //creating artist with the given values
        let webPost = ["title": titleLabel.text! as String,
                       "field_tag": "\(picked!)",
            "body": bodyTextField.text! as String,
            "field_image": imageWebsiteURL as String]
        
        //adding the artist inside the generated unique key
        refWebPost.child(key).setValue(webPost)
    }
//    
//    static func toJSonString(data : Any) -> String {
//        
//        var jsonString = "";
//        
//        do {
//            
//            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
//            jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
//            
//        } catch {
//            print(error.localizedDescription)
//        }
//        
//        return jsonString;
//    }
//    
   
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        
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
    
    
    
    
    @IBAction func saveButtonTapped(_ sender: Any) {

        if imageWebsiteURL != nil {
            saveWebPost()
        } else {
            print("ImageURL is nil, see: \(imageWebsiteURL)")
        }
        
        
        
    }
    
    
    func jsonToString(json: AnyObject){
        do {
            let data1 =  try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted) // first of all convert json to the data
            let convertedString = String(data: data1, encoding: String.Encoding.utf8) // the data will be converted to the string
            print(convertedString ?? "defaultvalue")
        } catch let myJSONError {
            print(myJSONError)
        }
        
    }
    
    



}


