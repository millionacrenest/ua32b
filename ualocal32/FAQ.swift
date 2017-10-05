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



struct FAQ {
    
    let key: String
    let ref: DatabaseReference?
    let question: String?
    var answer: String?
    
    
    
    init(question: String, answer: String, key: String = "") {
        self.key = key
        self.question = question
        self.answer = answer
        self.ref = nil
        
        
        
    }
    
    
    
    init?(snapshot: DataSnapshot) {
        key = snapshot.key
        let snapshotValue = snapshot.value as? [String: AnyObject]
        question = snapshotValue?["question"] as? String
        answer = snapshotValue?["answer"] as? String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "question": question,
            "answer": answer
            
        ]
    }
    
}
