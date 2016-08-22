//
//  File.swift
//  GuideOfLol
//
//  Created by Admin on 8/3/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class ChampionDto {
    var id: Int?
    var name : String?
    var allytips : [String]?
    var image: String?
    var info: InfoDto?
    var skins : [SkinDto]?
    var spells:	[ChampionSpellDto]?
    var stats:	StatsDto?
    var tags:	[String]?
    var title : String?
    var nameImg : String?
    var lore : String?
    var key : String?
    var recommended : [RecommendedDto]?
    
    
    init(id : Int, name: String , allytips: [String],spells: [ChampionSpellDto], info : InfoDto, stats: StatsDto, tags: [String],skins: [SkinDto], title : String, lore : String, key : String, image: String, recommended : [RecommendedDto]) {
        self.id = id
        self.name = name
        self.info = info
        self.allytips = allytips
        self.stats = stats
        self.tags = tags
        self.spells = spells

        self.skins  = skins
        self.title = title
        self.lore = lore
        self.key = key
        self.image = image
        self.recommended = recommended
        
    }
    
    init(id: Int, name: String ,image: String) {
        self.id = id
        self.image = image
        self.name = name
        
    }
    

}
