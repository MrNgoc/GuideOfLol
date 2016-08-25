//
//  OverviewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/5/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

extension UILabel {
    func boGoc() {
        layer.cornerRadius = 7
        layer.masksToBounds = true
    }
}

class OverviewController: UIViewController {
    var champ : ChampionDto?
    
    @IBOutlet weak var lblAttack: UILabel!
    
    @IBOutlet weak var lblDefence: UILabel!
    
    @IBOutlet weak var lblMagic: UILabel!
    
    @IBOutlet weak var lblDifficulty: UILabel!
    
    
    @IBOutlet weak var attack_Label: UILabel!
    
    @IBOutlet weak var defence_Label: UILabel!
    
    @IBOutlet weak var magic_Label: UILabel!
    
    @IBOutlet weak var difficulty_Label: UILabel!
    
    @IBOutlet weak var storyTextView: UITextView!
    
    
    let attackLabel : UILabel =  {
        let label = UILabel()
        label.backgroundColor = UIColor.redColor()
        label.boGoc()
        return label
    }()
    
    let defenceLabel : UILabel =  {
        let label = UILabel()
        label.boGoc()
        label.backgroundColor = UIColor.greenColor()
        return label
    }()
    
    let magicLabel : UILabel =  {
        let label = UILabel()
        label.boGoc()
        label.backgroundColor = UIColor.blueColor()
        return label
    }()
    
    let difficultyLabel : UILabel =  {
        let label = UILabel()
        label.boGoc()
        label.backgroundColor = UIColor.purpleColor()
        return label
    }()
    
    //    UIView.animateWithDuration(0.5) {
    //    UIView.transitionWithView(self.searchController, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromTop, animations: {
    //    self.searchController.hidden = !self.searchController.hidden
    //    }, completion: nil)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        if  let attackValue = champ?.info?.attack,      defenceValue = champ?.info?.defense,
            difficultyValue  = champ?.info?.difficulty,  magicValue = champ?.info?.magic,
            allytipsValue   = champ?.allytips , storyValue = champ?.lore{
            
            lblAttack.text = String(attackValue)
            lblDefence.text = String(defenceValue)
            lblMagic.text = String(magicValue)
            lblDifficulty.text = String(difficultyValue)
            
            //            let height = (view.frame.height * 51 * 20 / (408 * 71))
            let height = CGFloat(16)
            let width = (view.frame.width * 215) / (320 * 10)
            
            let widthAttack = width * CGFloat(attackValue)
            let widthDefence = width * CGFloat(defenceValue)
            let widthMagic = width * CGFloat(magicValue)
            let widthDifficulty = width * CGFloat(difficultyValue)
            
            
            attackLabel.frame = CGRectMake(-widthAttack, 0 , widthAttack, height)
            defenceLabel.frame = CGRectMake(-widthDefence, 0, widthDefence, height)
            magicLabel.frame = CGRectMake(-widthMagic, 0, widthMagic, height)
            difficultyLabel.frame = CGRectMake(-widthDifficulty, 0, widthDifficulty, height)
            
            UIView.animateWithDuration(1, animations: {
                self.attackLabel.center.x += widthAttack
                self.defenceLabel.center.x += widthDefence
                self.magicLabel.center.x += widthMagic
                self.difficultyLabel.center.x += widthDifficulty
                
                }, completion: nil)
            
            var text : String = ""
            for i in allytipsValue {
                text += i + " "
            }
            
            var e = "<b><font color=\"#CFBA6B\" size=\"6px\">LORE</font></b><br>"
            text = e + "<font color=\"white\" size=\"4px\">" + text + "</font><br><br>"
            
            
            e = "<b><font color=\"#CFBA6B\" size=\"6px\">STORY</font></b><br>"
            text = text + e + "<font color=\"white\" size=\"4px\">" + storyValue + "</font>"
            
            storyTextView.text = text
            
            let attr = try! NSAttributedString(data: text.dataUsingEncoding(NSUnicodeStringEncoding,allowLossyConversion: true)!,options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            storyTextView.attributedText = attr
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        attack_Label.boGoc()
        defence_Label.boGoc()
        magic_Label.boGoc()
        difficulty_Label.boGoc()
        
        attack_Label.addSubview(attackLabel)
        defence_Label.addSubview(defenceLabel)
        magic_Label.addSubview(magicLabel)
        difficulty_Label.addSubview(difficultyLabel)
        
        
    }
}
