//
//  Runes.swift
//  GuideOfLol
//
//  Created by Admin on 8/15/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class Runes{
    var name: String?
    var description: String?
    var id: String?
    var image: String?
    var rune: MetaDataDto?
    
    init(name: String, description: String, id: String, image: String, rune: MetaDataDto ) {
        self.name = name
        self.description = description
        self.id = id
        self.image = image
        self.rune = rune
           
    }

}
