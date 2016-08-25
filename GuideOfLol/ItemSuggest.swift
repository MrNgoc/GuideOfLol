//
//  ItemSuggest.swift
//  GuideOfLol
//
//  Created by Admin on 8/18/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class ItemSugggest {


    var map : String?
    var id : [String]?
    
    var type: String?
    
    init(map: String, id: [String], type: String) {
    self.id = id
    self.map = map
    self.type = type
    
    }
}
