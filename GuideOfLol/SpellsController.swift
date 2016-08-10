//
//  SpellsController.swift
//  GuideOfLol
//
//  Created by Admin on 8/5/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class SpellsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableview: UITableView!
    var champ : ChampionDto?
    
    var champSpells = [ChampionSpellDto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        champSpells = (champ?.spells)!
//        myTableview.rowHeight =  UITableViewAutomaticDimension
//        
//        myTableview.estimatedRowHeight = 400
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return champSpells.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
        let a = "http://ddragon.leagueoflegends.com/cdn/6.12.1/img/spell/"
        
        let champCurr = champSpells[indexPath.row]
        if let nameSkill = champCurr.name, cost = champCurr.cost, cooldown = champCurr.cooldownBurn, range = champCurr.range, description = champCurr.description, urlImage = champCurr.altimages?.full {
            cell.lbl_nameSkill.text = nameSkill
            //cell.lbl_nameSkill.autoresizingMask = .FlexibleWidth
            
            cell.lbl_CD.text = cooldown

            cell.lbl_Cost.text = toString(cost)
            
            cell.lbl_range.text = toString(range)
            
            let attr = try! NSAttributedString(data: description.dataUsingEncoding(NSUnicodeStringEncoding,allowLossyConversion: true)!,options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            cell.tv_description.text = description
            cell.tv_description.attributedText = attr
            
            let  urlImagefinish = a+urlImage
            
            let url = NSURL(string: urlImagefinish)
            let data = NSData(contentsOfURL: url!)
            cell.imageSkill.image = UIImage(data: data!)
        }
        
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
    
}
