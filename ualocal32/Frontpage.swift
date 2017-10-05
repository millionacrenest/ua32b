
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



struct Frontpage {
    
    let key: String
    let ref: DatabaseReference?
    let body: String?
    let title: String?
    let field_media_single: String?
    let term_node_nid: String?

    var comments: [Comments]!
    
    
    init(title: String, term_node_nid: String, body: String, field_media_single: String, key: String = "",  comments: [Comments]) {
        self.key = key
        self.title = title
        self.body = body
        self.field_media_single = field_media_single
        self.term_node_nid = term_node_nid
       
        self.ref = nil
        self.comments = comments
        
        
    }
    
    init?(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as? [String: AnyObject]
        term_node_nid = (snapshotValue?["term_node_nid"] as? String)
        title = (snapshotValue?["title"] as? String)
        body = (snapshotValue?["body"] as? String)
        field_media_single = snapshotValue?["field_media_single"] as? String
        ref = snapshot.ref
        comments = (snapshotValue?["comments"] as? [DataSnapshot])?.map({ Comments(snapshot: $0) })
    }
    
    func toAnyObject() -> Any {
        return [
            "title": title,
            "body": body,
            "field_media_single": field_media_single,
            "term_node_nid" : term_node_nid,
            "comments": comments
            
        ]
    }
    
}

