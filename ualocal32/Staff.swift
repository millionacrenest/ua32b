
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



struct Staff {
    
    let key: String
    let ref: DatabaseReference?
    let field_full_name: String?
    let field_local_32_member_since: String?
    let field_on_staff_since: String?
    let field_profile_picture: String?
    let field_tags: String?
    let field_type: String?
    let field_email: String?
    let uid: String?
    
    
    
    init(field_full_name: String, field_local_32_member_since: String, field_on_staff_since: String, field_profile_picture: String, field_tags: String, field_type: String, uid: String, field_email: String, key: String = "") {
        self.key = key
        self.field_full_name = field_full_name
        self.field_local_32_member_since = field_local_32_member_since
        self.field_on_staff_since = field_on_staff_since
        self.field_profile_picture = field_profile_picture
        self.field_tags = field_tags
        self.field_type = field_type
        self.field_email = field_email
        self.uid = uid
        self.ref = nil
        
    }
    
    init?(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as? [String: AnyObject]
        field_full_name = (snapshotValue?["field_full_name"] as? String)
        field_local_32_member_since = (snapshotValue?["field_local_32_member_since"] as? String)
        field_on_staff_since = snapshotValue?["field_on_staff_since"] as? String
        field_profile_picture = snapshotValue?["field_profile_picture"] as? String
        field_tags = snapshotValue?["field_contractor_type"] as? String
        field_type = snapshotValue?["field_type"] as? String
        field_email = snapshotValue?["field_email"] as? String
        uid = snapshotValue?["uid"] as? String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "field_full_name": field_full_name,
            "field_local_32_member_since": field_local_32_member_since,
            "field_on_staff_since": field_on_staff_since,
            "field_profile_picture": field_profile_picture,
            "field_tags": field_tags,
            "field_type": field_type,
            "field_email": field_email,
            "uid": uid
            
        ]
    }
    
}

