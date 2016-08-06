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
        if  let attackValue     = champ?.info?.attack,      healthValue = champ?.info?.defense,
            difficultValue  = champ?.info?.difficulty,  spellsValue = champ?.info?.magic,
            allytipsValue   = champ?.allytips
        {
            lblAttack.text = String(attackValue)
            lblHealth.text = String(healthValue)
            lblDifficult.text = String(difficultValue)
            lblSpells.text = String(spellsValue)
            
            var text : String = ""
            for i in allytipsValue {
                text += i + " "
            }
            tvAllytips.text = text
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
}
