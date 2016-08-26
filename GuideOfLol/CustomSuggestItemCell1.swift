//
//  CustomSuggestItemCell.swift
//  GuideOfLol
//
//  Created by Admin on 8/18/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class CustomSuggestedItemCell1: UICollectionViewCell {
    
    
    @IBOutlet weak var ImageItem: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.borderWidth = 1
        layer.borderColor =  UIColor.yellowColor().CGColor
        
    }
    
}
