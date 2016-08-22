//
//  CustomButton.swift
//  GuideOfLol
//
//  Created by Le Ha Thanh on 8/18/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class CustomButton: UIButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = layer.frame.width / 2
    }

}
