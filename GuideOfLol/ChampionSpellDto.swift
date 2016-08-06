//
//  123.swift
//  GuideOfLol
//
//  Created by Admin on 8/5/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

class ChampionSpellDto {
    var name: String?
    
    var altimages: 	[ImageDto]?
    var cost: [Int]?
    var cooldownBurn: String?
    var range: [Double]?
    
    var description: String?
    
    //  var tooltip: String?
    

    init(name: String, altimages: [ImageDto], cost: [Int], cooldownBurn: String, range: [Double], description: String) {
        self.name = name
        self.altimages = altimages

        self.cost = cost
        self.cooldownBurn = cooldownBurn
        self.range = range
        self.description = description
    }
}