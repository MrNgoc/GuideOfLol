//
//  StatsViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/6/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class StatsViewController: UIViewController {
    var champ: ChampionDto?
    @IBOutlet weak var lbl_Attack: UILabel!
    
    @IBOutlet weak var lbl_moveSpeed: UILabel!
    
    
    @IBOutlet weak var lbl_Amor: UILabel!
    
    @IBOutlet weak var lbl_MagicSpell: UILabel!
    
    @IBOutlet weak var lbl_Health: UILabel!
    
    @IBOutlet weak var lbl_healthRegen: UILabel!
    
    @IBOutlet weak var lbl_attackPerlevel: UILabel!
    
    @IBOutlet weak var lbl_AmorPerLevel: UILabel!
    
    @IBOutlet weak var lbl_magicSpellPerlevel: UILabel!
    
    @IBOutlet weak var lbl_HealthPerlevel: UILabel!
    
    @IBOutlet weak var lbl_HealthRegenPerLevel: UILabel!
    
    @IBOutlet weak var lbl_Level: UILabel!
    
    
    @IBOutlet weak var Slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setValue(1)
        
    }
    func setValue(value : Int) {
        if let statsAttackdamage = champ!.stats?.attackdamage, moveSpeed = champ?.stats?.movespeed,
            armor = champ?.stats?.armor, SpellBlock = champ?.stats?.spellblock,
            health = champ?.stats?.hp, healthRegen = champ?.stats?.hpregen,
            attackPerlevel = champ?.stats?.attackdamageperlevel, armorPerlevel = champ?.stats?.armorperlevel,
            spellBlockPerlevel = champ?.stats?.spellblockperlevel, healthPerlevel = champ?.stats?.hpperlevel,
            healthRegenPerlevel = champ?.stats?.hpregenperlevel
        {
            let attackValue = Double(value) * attackPerlevel + statsAttackdamage
            let amorValue = Double(value) * armorPerlevel + armor
            let healthValue = Double(value) * healthPerlevel + health
            let spellValue = Double(value) * spellBlockPerlevel + SpellBlock
            let healthRegenValue = Double(value) * healthRegenPerlevel + healthRegen
            
            
            lbl_Attack.text = String(attackValue)
            
            lbl_moveSpeed.text = String(moveSpeed)
            
            lbl_Amor.text = String(amorValue)
            lbl_MagicSpell.text = String(spellValue)
            
            lbl_Health.text = String(healthValue)
            
            lbl_healthRegen.text = String(healthRegenValue)
            
            lbl_attackPerlevel.text = String(attackPerlevel)
            
            lbl_AmorPerLevel.text = String(armorPerlevel)
            lbl_magicSpellPerlevel.text = String(spellBlockPerlevel)
            lbl_HealthPerlevel.text = String(healthPerlevel)
            lbl_HealthRegenPerLevel.text = String(healthRegenPerlevel)
            
        }
        
    }
    
    
    @IBAction func ActionSlider(sender: UISlider) {
        let value = Int(Slider.value)
        lbl_Level.text =  "Level " + String(value)
        setValue(value)
    }
    
}
