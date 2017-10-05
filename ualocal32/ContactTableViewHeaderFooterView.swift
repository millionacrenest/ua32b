//
//  ContactTableViewHeaderFooterView.swift
//  ualocal32
//
//  Created by Allison Mcentire on 9/1/17.
//  Copyright © 2017 Allison Mcentire. All rights reserved.
//

import UIKit

protocol ContactTableViewHeaderFooterViewDelegate {
    func toggleSection(header: ContactTableViewHeaderFooterView, section: Int)
}

class ContactTableViewHeaderFooterView: UITableViewHeaderFooterView {
    
    var delegate: ContactTableViewHeaderFooterViewDelegate?
    var section: Int!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(selectHeaderAction)))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectHeaderAction(gestureRecognizer: UITapGestureRecognizer){
        let cell = gestureRecognizer.view as! ContactTableViewHeaderFooterView
        delegate?.toggleSection(header: self, section: cell.section)
    }
    
    func customInit(title: String, section: Int, delegate: ContactTableViewHeaderFooterViewDelegate) {
    self.textLabel?.text = title
    self.section = section
    self.delegate = delegate
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.textLabel?.textColor = UIColor.white
        self.contentView.backgroundColor = UIColor.blue
    }
    
    


}
