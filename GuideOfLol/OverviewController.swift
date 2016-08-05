//
//  OverviewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/5/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class OverviewController: UIViewController {
    var champ : ChampionDto?
    
    @IBOutlet weak var lblAttack: UILabel!
    
    @IBOutlet weak var lblHealth: UILabel!
    
    @IBOutlet weak var lblDifficult: UILabel!
    
    @IBOutlet weak var lblSpells: UILabel!
    
    @IBOutlet weak var tvAllytips: UITextView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if let attackValue = champ?.info?.attack {
            lblAttack.text = String(attackValue)
        }
        if let healthValue = champ?.info?.defense {
            lblHealth.text = String(healthValue)
        }
        if let difficultValue = champ?.info?.difficulty {
            lblDifficult.text = String(difficultValue)
        }
        if let spellsValue = champ?.info?.magic {
            lblSpells.text = String(spellsValue)
        }
        
            print(champ?.allytips)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
}
