//
//  SpellsController.swift
//  GuideOfLol
//
//  Created by Admin on 8/5/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class SpellsController: UIViewController {
    
    var champ : ChampionDto?
    var champSpells = [ChampionSpellDto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        champSpells = (champ?.spells)!
//        for i in champSpells {
//            let champSpell : ChampionSpellDto =  i
//            print(champSpell.name[0])
//        }
        print(champSpells[0].cost)
        print(champSpells[0].altimages?.full)
    }
}
