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
    
//    let attackLabel : UILabel =  {
//    let label = UILabel()
//    
//    return label
//    }()
    let healthLabel : UILabel =  {
        let label = UILabel()
        
        return label
    }()
    let difficultyLabel : UILabel =  {
        let label = UILabel()
        
        return label
    }()
    
    let spellLabel : UILabel =  {
        let label = UILabel()
        
        return label
    }()
    
    
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
            
            view.addSubview(healthLabel)
            view.addSubview(difficultyLabel)
            view.addSubview(spellLabel)
            let attackLabel = UILabel(frame: CGRectMake(190, 7 , 10 * CGFloat(attackValue), 20))
            view.addSubview(attackLabel)
            attackLabel.backgroundColor = UIColor.redColor()
             healthLabel.backgroundColor = UIColor.yellowColor()
            difficultyLabel.backgroundColor = UIColor.purpleColor()
            spellLabel.backgroundColor = UIColor.blueColor()
            
            
            healthLabel.frame = CGRectMake(190, 40, 10 * CGFloat(healthValue), 20)
            difficultyLabel.frame = CGRectMake(190, 68, 10 * CGFloat(difficultValue), 20)
            spellLabel.frame = CGRectMake(190, 98, 10 * CGFloat(spellsValue), 20)
            
            var text : String = ""
            for i in allytipsValue {
                text += i + " "
            }
            
            let attr = try! NSAttributedString(data: text.dataUsingEncoding(NSUnicodeStringEncoding,allowLossyConversion: true)!,options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            tvAllytips.text = text
            tvAllytips.attributedText = attr

        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
}
