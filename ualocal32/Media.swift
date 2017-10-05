//
//  Media.swift
//  ualocal32
//
//  Created by Allison Mcentire on 8/24/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//



import Foundation
import Firebase
import FirebaseDatabase



struct Media {
    
    let key: String
    let ref: DatabaseReference?
    let mid: String?
    var url: String?

    
    
    init(url: String, mid: String, key: String = "") {
        self.key = key
        self.url = url
        self.mid = mid
        self.ref = nil

        
        
    }
    
    
    
    init?(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as? [String: AnyObject]
        url = snapshotValue?["field_image"] as? String
        mid = snapshotValue?["mid"] as? String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "url": url,
            "mid": mid
            
        ]
    }
    
}
