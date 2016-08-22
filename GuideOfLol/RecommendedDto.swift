//
//  RecommendedDto.swift
//  GuideOfLol
//
//  Created by Admin on 8/18/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import Foundation

class RecommendedDto {
    var blocks : [BlockDto]?
    var map	: String?
    
    init (blocks : [BlockDto], map : String) {
        self.blocks = blocks
        self.map = map
    }
    
}

class BlockDto {
    var items : [String]?
    var type : String?
    
    init (items : [String], type : String){
        self.items = items
        self.type = type
    }
}