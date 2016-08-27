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
        cell.backgroundColor = UIColor.clearColor()
        
        let champCurr = champSpells[indexPath.row]
        if let nameSkill = champCurr.name,
            cooldown = champCurr.cooldownBurn, urlImage = champCurr.altimages?.full, var description = champCurr.description, var cost = champCurr.cost, range = champCurr.range {
            cell.lbl_nameSkill.text = nameSkill
            
            cell.lbl_CD.text = cooldown
            cost = checkValue(cost)
            cell.lbl_Cost.text = toString(cost)
            range = checkValue(range)
            cell.lbl_range.text = toString(range)
            
            description = "<font color=\"white\" size=\"4px\"><b>" + description + "</b></font>"
            
            let attr = try! NSAttributedString(data: description.dataUsingEncoding(NSUnicodeStringEncoding,allowLossyConversion: true)!,options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            
            cell.lbl_description.text = description
            cell.lbl_description.attributedText = attr
            
            cell.imageSkill.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(urlImage, ofType: "")!)
        }
        
        return cell
    }
    
    func checkValue(cost : [Double]) -> [Double]{
        
        var temp = [Double]()
        for i in 1..<cost.count {
            if cost[0] != cost[i] {
                return cost
            }
            
        }
        temp.append(cost[0])
        
        return temp
        
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
        
        return 100
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
