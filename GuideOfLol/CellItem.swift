//
//  CustomCell.swift
//  GuideOfLol
//
//  Created by Admin on 8/3/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

//  CellItem.swift
//  Example
//
//  Created by Le Ha Thanh on 7/22/16.
//  Copyright © 2016 le ha thanh. All rights reserved.
//

import UIKit
class  CellItem: UICollectionViewCell {
    var nameLabel: UILabel!
    var imageView: UIImageView!
    var price: UILabel!
    var kPriceLabelHight: CGFloat = 30
    var kCellWidth: CGFloat = 100
    var kLabelHeight: CGFloat = 30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
        
    }
    
    func addSubviews() {
        if (imageView == nil) {
            imageView = UIImageView(frame: CGRectMake(0, 0, kCellWidth, kCellWidth))
            imageView.layer.borderColor = tintColor.CGColor
            imageView.contentMode = .ScaleAspectFill
            contentView.addSubview(imageView)
        }
        
        
        if (nameLabel == nil) {
            nameLabel = UILabel(frame: CGRectMake(0, 100, kCellWidth, kLabelHeight))
            nameLabel.textAlignment = .Center
            nameLabel.textColor = UIColor.blueColor()
            nameLabel.highlightedTextColor = tintColor
            nameLabel.font = UIFont.boldSystemFontOfSize(12)
            //nameLabel.numberOfLines = 2
            contentView.addSubview(nameLabel)
            
        }
    }
    
    
}