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
        
        
        //        for i in champSpells {
        //            let champSpell : ChampionSpellDto =  i
        //            print(champSpell.name[0])
        //        }
        print(champSpells[0].cost)
        print(champSpells[0].altimages?.full)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return champSpells.count
    }
    
    
    //http://ddragon.leagueoflegends.com/cdn/6.12.1/img/passive/Aatrox_Passive.png
    //http://ddragon.leagueoflegends.com/cdn/6.12.1/img/spell/AatroxQ.png
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomTableViewCell
        var a = "http://ddragon.leagueoflegends.com/cdn/6.12.1/img/spell/"
        
        var champCurr = champSpells[indexPath.row]
        if let nameSkill = champCurr.name, cost = champCurr.cost, cooldown = champCurr.cooldownBurn, range = champCurr.range, description = champCurr.description, urlImage = champCurr.altimages?.full {
            cell.lbl_nameSkill.text = nameSkill
            cell.lbl_Cost.text = String(cost)
            cell.lbl_CD.text = cooldown
            cell.lbl_range.text = String(range)
            
            cell.tv_description.text = description
            
            let  urlImagefinish = a+urlImage
            
            let url = NSURL(string: urlImagefinish)
            let data = NSData(contentsOfURL: url!)
            cell.imageSkill.image = UIImage(data: data!)
            
            
            //
            //            let imageURL = champions[indexPath.item].image
            //
            //            let url = NSURL(string: imageURL!)
            //
            //            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            //                let data = NSData(contentsOfURL: url!)
            //
            //                dispatch_async(dispatch_get_main_queue(), {
            //                    if let realData = data  {
            //                        cell.imageView.image = UIImage(data: realData)
            //                    }
        }
        
        
        
        
        
        
        return cell
    }
    
    
    
    
    
    
}
