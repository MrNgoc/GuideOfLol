//
//  SpellsController.swift
//  GuideOfLol
//
//  Created by Admin on 8/5/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class SpellsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var champ : ChampionDto?
    
    var champSpells = [ChampionSpellDto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        champSpells = (champ?.spells)!
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return champSpells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
        let a = "http://ddragon.leagueoflegends.com/cdn/6.12.1/img/spell/"
        
        let champCurr = champSpells[indexPath.row]
        if let nameSkill = champCurr.name, cost = champCurr.cost, cooldown = champCurr.cooldownBurn, range = champCurr.range, urlImage = champCurr.altimages?.full, var description = champCurr.description {
            cell.lbl_nameSkill.text = nameSkill
            
            cell.lbl_CD.text = cooldown
            
            cell.lbl_Cost.text = toString(cost)
            
            cell.lbl_range.text = toString(range)
            
            description = "<font color=\"white\" size=\"4px\"><b>" + description + "</b></font>"
            
            let attr = try! NSAttributedString(data: description.dataUsingEncoding(NSUnicodeStringEncoding,allowLossyConversion: true)!,options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            cell.lbl_description.text = description
            cell.lbl_description.attributedText = attr
            
            let  urlImagefinish = a+urlImage
            let url = NSURL(string: urlImagefinish)
           
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                let data = NSData(contentsOfURL: url!)
                
                dispatch_async(dispatch_get_main_queue(), {
                    if let realData = data  {
                         cell.imageSkill.image = UIImage(data: data!)                    }
                })
            }

        }
        
//        tableView.separatorColor = UIColor.whiteColor()
//        tableView.separatorInset = UIEdgeInsetsZero
//        tableView.separatorStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func toString(value: [AnyObject]) -> String {
        var result : String = ""
        for i in 0..<value.count {
            if i < (value.count - 1) {
                result = result + String(value[i]) + "/"
            } else {
                result = result + String(value[i])
            }
        }
        
        return result;
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 50
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    
    
}
