//
//  MasterTableVC.swift
//  GuideOfLol
//
//  Created by Le Ha Thanh on 8/4/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON

class MasterTableVC: UIViewController {
    @IBOutlet weak var overView: UIView!
    @IBOutlet weak var spellsView: UIView!
    @IBOutlet weak var statsView: UIView!
    @IBOutlet weak var storyView: UIView!
    @IBOutlet weak var skinsView: UIView!
    
    var champ : ChampionDto?
    
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
        if segue.identifier == "view0Segue" {
            let view0 = segue.destinationViewController as? OverviewController
            view0?.champ = champ
        }

        if segue.identifier == "stats" {
            let stats = segue.destinationViewController as! StatsViewController
            stats.champ = champ
            print(stats.champ)
            
            
        }
    }
    
}
