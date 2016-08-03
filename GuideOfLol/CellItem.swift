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
    }
    
    func addSubviews(checkAddAll: Bool) {
        if (imageView == nil) {
            imageView = UIImageView(frame: CGRectMake(0, 0, kCellWidth, kCellWidth))
            imageView.layer.borderColor = tintColor.CGColor
            imageView.contentMode = .ScaleAspectFit
            contentView.addSubview(imageView)
        }
        
        if (checkAddAll) {
            if (nameLabel == nil) {
                nameLabel = UILabel(frame: CGRectMake(0, kCellWidth, kCellWidth, kLabelHeight))
                nameLabel.textAlignment = .Left
                nameLabel.textColor = UIColor(white: 0.9, alpha: 1.0)
                nameLabel.highlightedTextColor = tintColor
                nameLabel.font = UIFont.boldSystemFontOfSize(10)
                nameLabel.numberOfLines = 2
                contentView.addSubview(nameLabel)
                
            }
            
            if (price == nil) {
                price = UILabel(frame: CGRectMake(0, kCellWidth + kLabelHeight, kCellWidth, kPriceLabelHight))
                price.textAlignment = .Left
                price.textColor = UIColor(red: 255/255, green: 116/255, blue: 35/255, alpha: 1)
                price.font = UIFont.boldSystemFontOfSize(12)
                contentView.addSubview(price)
            }
        }
    }
    
    
}