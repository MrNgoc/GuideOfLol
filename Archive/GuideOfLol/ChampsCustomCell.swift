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
    var viewBackGround: UIView!
    var kCellWidth: CGFloat = (UIScreen.mainScreen().bounds.width - 40) / 4.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        addSubviews()
//        layer.borderWidth = 1
//        layer.borderColor =  UIColor(red:255/255, green:51/255.0, blue:51/255, alpha: 1.0).CGColor
        
    }
    
    func addSubviews() {
        if (imageView == nil) {
            imageView = UIImageView(frame: CGRectMake(0, 0, kCellWidth, kCellWidth))
            imageView.layer.borderColor = tintColor.CGColor
            imageView.contentMode = .ScaleAspectFill
            contentView.addSubview(imageView)
        }
//        elf.yourView.layer.borderWidth = 1
//        self.yourView.layer.borderColor = UIColor(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).CGColor
        
        if (nameLabel == nil && viewBackGround == nil) {
            nameLabel = UILabel(frame: CGRectMake(0, 0.75 * kCellWidth, kCellWidth,  0.25 * kCellWidth))
            viewBackGround = UIView(frame: CGRectMake(0, 0.75 * kCellWidth, kCellWidth,  0.25 * kCellWidth))
            viewBackGround.backgroundColor = UIColor.blackColor()
            viewBackGround.alpha = 0.4
            
            nameLabel.textAlignment = .Center
            nameLabel.textColor = UIColor.whiteColor()
            nameLabel.backgroundColor = UIColor.clearColor()
            nameLabel.highlightedTextColor = tintColor
            nameLabel.font = UIFont.boldSystemFontOfSize(11)
            
            contentView.addSubview(viewBackGround)
            contentView.addSubview(nameLabel)
            
            
        }
    }
    
    
}