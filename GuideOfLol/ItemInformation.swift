//
//  ItemInformation.swift
//  GuideOfLol
//
//  Created by Admin on 8/22/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import Foundation

class ItemInformation {
    var id: String?
    var description: String?
    var name: String?
    var gold: String?
    
    
    init(id: String, description: String, name: String, gold: String) {
    
        self.id = id
        self.description = description
        self.name = name
        self.gold = gold
    
    
    }


}