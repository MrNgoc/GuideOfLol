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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        champName.text = champ?.name
        
        guard let id = champ?.id else  {return}
        getDataOfChampion(id)
        
    }
    
    func getDataOfChampion(idChamp : Int) {
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion/\(idChamp)?champData=all&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let responseHTTP = response as? NSHTTPURLResponse{
                    if responseHTTP.statusCode == 200 {
                        
                        let json = JSON(data:data!)
                        // print(json)
                        // lay title
                        let titleChamp = json["title"].stringValue
                        
                        // lay allytips
                        let allytipsChamp  = json["allytips"]
                        
                        
                        let infoJSON  = json["info"]
                        let attack = infoJSON["attack"].intValue
                        let defense = infoJSON["defense"].intValue
                        let magic = infoJSON["magic"].intValue
                        let difficulty = infoJSON["difficulty"].intValue
                        
                        let infoChamp = InfoDto(attack: attack, defense: defense, difficulty: difficulty, magic: magic)
                        let tagsChamp = json["tags"]
                        
                        var tag : [String] = []
                        for i in tagsChamp {
                            tag.append(i.1.string!)
                        }
                        
                        self.champ = ChampionDto(title: titleChamp, tags: tag)
                        
                        self.printChampions(self.champ!)
                    }
                }
            }
            
            }.resume()
        
    }
    
    
    
    
    func printChampions(champs: ChampionDto)
    {
        champ = champs
        champTitle.text = champ?.title
        var tagLabel : String = ""
        for i in (champ?.tags)! {
            tagLabel = tagLabel  + i + ", "
        }
        champTags.text = tagLabel
        
    }
    
    @IBAction func actionSegement(sender: AnyObject) {
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
        case 4:
            overView.hidden = true
            spellsView.hidden = true
            statsView.hidden = true
            storyView.hidden = true
            skinsView.hidden = false
        default:
            break
        }
    }
    
}
