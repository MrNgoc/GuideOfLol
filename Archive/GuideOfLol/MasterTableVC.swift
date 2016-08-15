//
//  MasterTableVC.swift
//  GuideOfLol
//
//  Created by Le Ha Thanh on 8/4/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON

class MasterTableVC: BaseViewController {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var spellsView: UIView!
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var storyView: UIView!
    @IBOutlet weak var skinsView: UIView!
    
    @IBOutlet weak var fullchampimage: UIImageView!
    
    @IBOutlet weak var fullChampImage: UIView!
//    var champ : ChampionDto?
    
    var id: Int?
    var infoChamp : InfoDto?
    
    
    @IBOutlet weak var champImage: UIImageView!
    @IBOutlet weak var champName: UILabel!
    
    @IBOutlet weak var champTitle: UILabel!
    @IBOutlet weak var champTags: UILabel!
    
    @IBOutlet weak var segmentTitle: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        champName.text = champ?.name
        champTitle.text = champ?.title
        self.title = champ?.name
        guard let tagValues = champ?.tags else {return}
        var tagValue : String = ""
        for i in tagValues {
            tagValue = tagValue + i + ", "
        }
        champTags.text = tagValue
        let a = "http://ddragon.leagueoflegends.com/cdn/6.16.2/img/champion/"
    
        
        let b = "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/"
        
        guard let keyChamp = champ?.key else {return}
        
        let urlImagefinish = a + keyChamp + ".png"
        let urlfinishfullchamp = b + keyChamp + "_1.jpg"
        
        let url1 = NSURL(string: urlfinishfullchamp)
        
            
        let url = NSURL(string: urlImagefinish)
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let data1 = NSData(contentsOfURL: url1!)
            let data = NSData(contentsOfURL: url!)
            
            dispatch_async(dispatch_get_main_queue(), {
                self.champImage.image = UIImage(data: data!)
                self.fullchampimage.image = UIImage(data: data1!)
                
            })
        }
        
        
        overView.hidden = false
        spellsView.hidden = true
        statsView.hidden = true
        storyView.hidden = true
        skinsView.hidden = true
        
    }
    
    
    @IBAction func actionSegement(sender: AnyObject) {
        sender.selected
        switch sender.selectedSegmentIndex {
        case 0:
            overView.hidden = false
            spellsView.hidden = true
            statsView.hidden = true
            storyView.hidden = true
            skinsView.hidden = true
            
        case 1:
            overView.hidden = true
            spellsView.hidden = false
            statsView.hidden = true
            storyView.hidden = true
            skinsView.hidden = true
        case 2:
            overView.hidden = true
            spellsView.hidden = true
            statsView.hidden = false
            storyView.hidden = true
            skinsView.hidden = true
            
        case 3:
            overView.hidden = true
            spellsView.hidden = true
            statsView.hidden = true
            storyView.hidden = false
            skinsView.hidden = true
        default:
            overView.hidden = true
            spellsView.hidden = true
            statsView.hidden = true
            storyView.hidden = true
            skinsView.hidden = false
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "overview" {
            let view0 = segue.destinationViewController as? OverviewController
            view0?.champ = champ
        }
        
        if segue.identifier == "stats" {
            let stats = segue.destinationViewController as! StatsViewController
            stats.champ = champ
            
        }
        if segue.identifier == "spells" {
            let spells = segue.destinationViewController as! SpellsController
            spells.champ = champ
            
        }
        if segue.identifier == "skins" {
            let skins = segue.destinationViewController as! SkinsController
            skins.champ = champ
            
        }
        
        if segue.identifier == "story" {
            let story = segue.destinationViewController as! StoryViewController
            story.champ = champ
        }
        
    }
    
    
}
