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
    
    var id: Int?
    var infoChamp : InfoDto?
    
    
    @IBOutlet weak var champImage: UIImageView!
    @IBOutlet weak var champName: UILabel!
    
    @IBOutlet weak var champTitle: UILabel!
    @IBOutlet weak var champTags: UILabel!

    @IBOutlet weak var segmentTitle: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
               segmentTitle.removeBorders()
        segmentTitle.setTitleTextAttributes([ NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 12.0)! ],  forState: .Normal)

        
        champName.text = champ?.name
        champTitle.text = champ?.title
        self.title = champ?.name
        guard let tagValues = champ?.tags else {return}

            var result : String = ""
            for i in 0..<tagValues.count {
                if i < (tagValues.count - 1) {
                    result = result + String(tagValues[i]) + ", "
                } else {
                    result = result + String(tagValues[i])
                }
            }
        

        champTags.text = result
    
        
        let b = "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/"
        
        guard let keyChamp = champ?.key else {return}
        
        let urlfinishfullchamp = b + keyChamp + "_1.jpg"

        let url1 = NSURL(string: urlfinishfullchamp)

        self.champImage.image = UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource((champ?.image), ofType: "")!)
        

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let data1 = NSData(contentsOfURL: url1!)
            
            
            dispatch_async(dispatch_get_main_queue(), {
                
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
