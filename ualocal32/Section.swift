//
//  Section.swift
//  ualocal32
//
//  Created by Allison Mcentire on 9/1/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import Foundation

struct Section {
    var sectionName: String!
    var sectionObjects: [String]!
    var expanded: Bool!
    
    init(sectionName: String, sectionObjects: [String], expanded: Bool) {
        self.sectionName = sectionName
        self.sectionObjects = sectionObjects
        self.expanded = expanded
    }
}
