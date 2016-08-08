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
    
    
    init(name: String , allytips: [String],spells: [ChampionSpellDto], info : InfoDto, stats: StatsDto, tags: [String],skins: [SkinDto], title : String) {
        self.name = name
        self.info = info
        self.allytips = allytips
        self.stats = stats
        self.tags = tags
        self.spells = spells

        self.skins  = skins
        self.title = title
        
    }
    
    init(id: Int, name: String ,image: String) {
        self.id = id
        self.image = image
        self.name = name
        
    }
}
