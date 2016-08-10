//
//  ClassItemDto.swift
//  GuideOfLol
//
//  Created by Admin on 8/10/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit


class ItemDto {

    var fromID: [String]?
    var gold: GoldDto?
    var group: String?
    var id : Int?
    var image: ImageDtoItem?
    
    var name: String?
    var santizedDescription: String?
    
    init(fromID: [String], gold: GoldDto, group: String, id: Int, image: ImageDtoItem, name: String, santizedDescription: String ) {
        self.fromID = fromID
        
        self.gold = gold
        self.group = group
        self.id = id
        self.image = image
        self.name = name
        self.santizedDescription = santizedDescription
        
    
    
    }
    init(id: Int, image: ImageDtoItem,gold: GoldDto, name: String) {
        
        self.id = id
        self.image = image
        self.gold = gold
        self.name = name
    
    }
}

class ImageDtoItem {
    
    
    
    var full: String?
    
    
    init(full: String) {
    self.full = full
    
    }




}

