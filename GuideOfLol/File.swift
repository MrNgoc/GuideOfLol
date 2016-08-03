//
//  File.swift
//  GuideOfLol
//
//  Created by Admin on 8/3/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class ImageDto {
    var full: String?
    var group: String?
    var h: Int?
    var spite: String?
    var w: Int?
    var x: Int?
    var y: Int?
    
    
}

class InfoDto {
    
    
    var attack:	Int?
    var defense: Int?
    var difficulty:	Int?
    var magic:	Int?

}
class SkinDto {


}
class ChampionSpellDto {
    var name: String?
    
    var altimages: 	[ImageDto]?
    var cost: [Int]?
    var cooldownBurn: String?
    var range: [Double]?
   
    var description: String?
    
  //  var tooltip: String?
    
}
class StatsDto {
    var hp : Double?
    
    var hpperlevel: Double?
    var hpregen: Double?
    var hpregenperlevel: Double?
    var armor: Double?
    var armorperlevel: Double?
    var attackdamage: Double?
    var attackdamageperlevel: Double?
    var  spellblock: Double?
    var spellblockperlevel: Double?
    var movespeed: Double?

}


class ChampionDto: NSObject {
    var id: Int?
    var name : String?
    var allytips : [String]?
    
    var image: ImageDto?
    var info: InfoDto?
    var skins : [SkinDto]?
    
    var spells:	[ChampionSpellDto]?
    var stats:	StatsDto?
    var tags:	[String]?

    init(id: Int,image: ImageDto, name: String) {
        self.id = id
        self.image = image
        self.name = name
    
    }




}
