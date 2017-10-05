
//
//  File.swift
//  ualocal32
//
//  Created by Allison Mcentire on 6/15/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase



struct NodeLocation {
    
    let key: String
    let name: String
    let addedByUser: String
    let ref: DatabaseReference?
    let latitude: String?
    let longitude: String?
    let image: String?
    let tags: String?
    var comments: [Comments]!
 
    
    init(name: String, addedByUser: String, comment: String, longitude: String, latitude: String, image: String, tags: String, key: String = "",  comments: [Comments]) {
        self.key = key
        self.name = name
        self.addedByUser = addedByUser
        self.latitude = latitude
        self.longitude = longitude
        self.image = image
        self.tags = tags
        self.ref = nil
        self.comments = comments
       

    }
    
    init?(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as? [String: AnyObject]
        name = (snapshotValue?["locationName"] as? String)!
        addedByUser = (snapshotValue?["UID"] as? String)!
        latitude = snapshotValue?["locationLatitude"] as? String
        longitude = snapshotValue?["locationLongitude"] as? String
        image = snapshotValue?["locationPhoto"] as? String
        tags = snapshotValue?["locationTags"] as? String
        ref = snapshot.ref
        comments = (snapshotValue?["comments"] as? [DataSnapshot])?.map({ Comments(snapshot: $0) })
    }
    
    func toAnyObject() -> Any {
        return [
            "name": name,
            "addedByUser": addedByUser,
            "latitude": latitude,
            "longitude": longitude,
            "image": image,
            "tags": tags,
            "comments": comments
            
            
        ]
    }
    
}

