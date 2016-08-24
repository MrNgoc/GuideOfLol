//
//  DetailOfItem.swift
//  GuideOfLol
//
//  Created by Admin on 8/20/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class DetailOfItem: UIViewController {
    var id: String!
    var information: ItemInformation?
    
    @IBOutlet weak var ImageItem: UIImageView!
    
    @IBOutlet weak var NameItem: UILabel!
    
    @IBOutlet weak var PriceItem: UILabel!
    
    
    @IBOutlet weak var Description: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = information?.name {
            NameItem.text = name
            
        }
        if let id = information?.id {
            
            let url = id + ".png"
            self.ImageItem.layer.borderWidth = 1
            self.ImageItem.layer.borderColor = UIColor.yellowColor().CGColor
            
            
            self.ImageItem.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(url, ofType: "")!)
            
            
        }
        if let gold = information?.gold {
            PriceItem.text = gold + " vàng"
            
            
        }
        if let description = information?.description {
            let text = "<font color=\"white\" size=\"4px\">" + description + "</font>"
            let attr = try! NSAttributedString(data: text.dataUsingEncoding(NSUnicodeStringEncoding,allowLossyConversion: true)!,options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            
            Description.text = text

            Description.attributedText = attr

            
        }
        
        
    }
    
}
