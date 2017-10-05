
//
//  ContractorTableViewCell.swift
//  
//
//  Created by Allison Mcentire on 8/18/17.
//
//

import UIKit



class ContractorTableViewCell : UITableViewCell{
    
    @IBOutlet weak var companyLabel: UILabel!
    
    @IBOutlet weak var contactLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    
    @IBOutlet weak var phoneNumberView: UITextView!
    

    
    class var expandedHeight: CGFloat { get { return 200 } }
    
    
    class var defaultHeight: CGFloat { get { return 100 } }
    
   
    
    
    
    func checkHeight() {
        phoneNumberView.isHidden = (frame.size.height < ContractorTableViewCell.expandedHeight)
    }
    
    func watchFrameChanges() {
        addObserver(self, forKeyPath: "frame", options: .new, context: nil)
        checkHeight()
        
    }
    
    func ignoreFrameChanges() {
        removeObserver(self, forKeyPath: "frame")
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "frame" {
            checkHeight()
        }
    }

    
   
  
    
    
    
    
}
