//
//  CustomRuneCell.swift
//  GuideOfLol
//
//  Created by Admin on 8/15/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
class CustomRuneCell: UITableViewCell {

    @IBOutlet weak var nameRune: UILabel!

    @IBOutlet weak var tierLabel: UILabel!
    @IBOutlet weak var Description: UILabel!

    @IBOutlet weak var ImageRune: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }

}