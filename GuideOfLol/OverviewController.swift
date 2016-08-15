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
    
    
    @IBOutlet weak var health_Label: UILabel!
    
    @IBOutlet weak var attack_Label: UILabel!
    
    @IBOutlet weak var spells_Label: UILabel!
    
    @IBOutlet weak var difficulty_Label: UILabel!
    
    
    let attackLabel : UILabel =  {
        let label = UILabel()
        label.backgroundColor = UIColor.redColor()
        return label
    }()
    
    let healthLabel : UILabel =  {
        let label = UILabel()
        label.backgroundColor = UIColor.redColor()
        return label
    }()
    
    let difficultyLabel : UILabel =  {
        let label = UILabel()
        label.backgroundColor = UIColor.redColor()
        return label
    }()
    
    let spellLabel : UILabel =  {
        let label = UILabel()
        label.backgroundColor = UIColor.redColor()
        return label
    }()
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if  let attackValue = champ?.info?.attack,      healthValue = champ?.info?.defense,
            difficultValue  = champ?.info?.difficulty,  spellsValue = champ?.info?.magic,
            allytipsValue   = champ?.allytips
        {
            
            lblHealth.text = String(healthValue)
            lblDifficult.text = String(difficultValue)
            lblSpells.text = String(spellsValue)
            lblAttack.text = String(attackValue)
            
            let height = (view.frame.height * 51 * 20 / (408 * 71))
            attackLabel.frame = CGRectMake(0, 0 , 14 * CGFloat(attackValue), height )
            
            healthLabel.frame = CGRectMake(0, 0, 14 * CGFloat(healthValue), height)
            difficultyLabel.frame = CGRectMake(0, 0, 14 * CGFloat(difficultValue), height)
            spellLabel.frame = CGRectMake(0, 0, 14 * CGFloat(spellsValue), height)
            
            var text : String = ""
            for i in allytipsValue {
                text += i + " "
            }
            
            text = "<font color=\"white\" size=\"4px\">" + text + "</font>"
            let attr = try! NSAttributedString(data: text.dataUsingEncoding(NSUnicodeStringEncoding,allowLossyConversion: true)!,options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            
            tvAllytips.text = text
            tvAllytips.attributedText = attr
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        health_Label.addSubview(healthLabel)
        difficulty_Label.addSubview(difficultyLabel)
        spells_Label.addSubview(spellLabel)
        attack_Label.addSubview(attackLabel)
    }
}
