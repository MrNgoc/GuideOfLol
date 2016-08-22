//
//  CustomImageView.swift
//  GuideOfLol
//
//  Created by Le Ha Thanh on 8/18/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.yellowColor().CGColor
    }

}
