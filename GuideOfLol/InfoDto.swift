//
//  InfoDto.swift
//  GuideOfLol
//
//  Created by Admin on 8/3/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//


import UIKit

class InfoDto {
    
    var attack:	Int?
    var defense: Int?
    var difficulty:	Int?
    var magic:	Int?
    
    init(attack : Int, defense: Int, difficulty: Int, magic : Int){
        self.attack = attack
        self.defense = defense
        self.difficulty = difficulty
        self.magic = magic
    }
}