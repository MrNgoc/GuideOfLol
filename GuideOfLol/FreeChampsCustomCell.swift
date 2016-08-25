//
//  CustomMainCell.swift
//  GuideOfLol
//
//  Created by Admin on 8/9/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class CustomMainCell: UICollectionViewCell {
    
    var ImageFreeChampion: UIImageView!
    var kCellWidth: CGFloat = (UIScreen.mainScreen().bounds.width - 30) / 5.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        if (ImageFreeChampion == nil) {
            ImageFreeChampion = UIImageView(frame: CGRectMake(0, 0, kCellWidth, kCellWidth))
            ImageFreeChampion.contentMode = .ScaleAspectFill
            contentView.addSubview(ImageFreeChampion)

            let image = UIImageView(frame: CGRectMake(0, 0, kCellWidth, kCellWidth))
            image.image = UIImage(named: "frame3")
            image.contentMode = .ScaleAspectFill
            contentView.addSubview(image)
        }
    }
}