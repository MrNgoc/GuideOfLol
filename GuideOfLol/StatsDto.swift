//
//  File12.swift
//  GuideOfLol
//
//  Created by Admin on 8/5/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//
class StatsDto {
    var hp : Double?
    var hpperlevel: Double?
    var hpregen: Double?
    var hpregenperlevel: Double?
    var armor: Double?
    var armorperlevel: Double?
    var attackdamage: Double?
    var attackdamageperlevel: Double?
    var spellblock: Double?
    var spellblockperlevel: Double?
    var movespeed: Double?
    
    
    init(hp : Double, hpperlevel: Double, hpregen: Double, hpregenperlevel: Double, armor: Double,
         armorperlevel: Double, attackdamage: Double, attackdamageperlevel: Double, spellblock: Double,spellblockperlevel: Double, movespeed: Double) {
        self.hp = hp
        self.hpperlevel = hpperlevel
        self.hpregen = hpregen
        self.hpregenperlevel = hpregenperlevel
        self.armor = armor
        self.armorperlevel = armorperlevel
        self.attackdamage = attackdamage
        self.attackdamageperlevel = attackdamageperlevel
        self.spellblock = spellblock
        self.spellblockperlevel = spellblockperlevel
        self.movespeed = movespeed
    }
}