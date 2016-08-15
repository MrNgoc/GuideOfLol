//
//  ViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/2/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON

let kDOCUMENT_DIRECTORY_PATH = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .AllDomainsMask, true).first

class ViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var myCollection: UICollectionView!

//    var champ : ChampionDto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
        self.title = "Champions LOL"
        
        let urlString = "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?locale=vn_VN&champData=image&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF"
        
        getData(urlString, collectionView: myCollection)
    }
    
    // lay anh + ten + id
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return champions.count
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CellItem
        
        let imageURL = champions[indexPath.item].image
        
        let url = NSURL(string: imageURL!)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let data = NSData(contentsOfURL: url!)
            
            dispatch_async(dispatch_get_main_queue(), {
                if let realData = data  {
                    cell.imageView.image = UIImage(data: realData)
                }
            })
        }
        
        if let name = champions[indexPath.item].name {
            cell.nameLabel.text = name
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (view.bounds.width - 40) / 4.0
        return CGSizeMake(width, width)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let v1 = storyboard?.instantiateViewControllerWithIdentifier("Master") as? MasterTableVC
        getDataOfChampion(champions[indexPath.item].id!, masterVC: v1!)
        
    }
    
    
    
    
//    func getDataOfChampion(idChamp : Int, masterVC : MasterTableVC) {
//        
//        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion/\(idChamp)?locale=vn_VN&champData=all&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
//        
//        let session = NSURLSession.sharedSession()
//        
//        session.dataTaskWithRequest(urlRequest) { (data, response, error) in
//            if let error = error
//            {
//                print(error.localizedDescription)
//            } else {
//                if let responseHTTP = response as? NSHTTPURLResponse
//                {
//                    if responseHTTP.statusCode == 200
//                    {
//                        
//                        let json = JSON(data:data!)
//                        
//                        // lay name + tag
//                        guard let idValue = json["id"].int else {return}
//                        guard let name = json["name"].string else { return }
//                        
//                        // lay title
//                        guard let titleChamp = json["title"].string else {return}
//                        
//                        // lay allytips
//                        let allytipsChamp = self.toString(json["allytips"])
//                        let infoJSON  = json["info"]
//                        
//                        guard let attack = infoJSON["attack"].int else {return}
//                        guard let defense = infoJSON["defense"].int else {return}
//                        guard let magic = infoJSON["magic"].int else {return}
//                        guard let difficulty = infoJSON["difficulty"].int else {return}
//                        
//                        let infoChamp = InfoDto(attack: attack, defense: defense, difficulty: difficulty, magic: magic)
//                        let tagsChamp = self.toString(json["tags"])
//                        
//                        //---------------------------------------- xong overview
//                        
//                        var listSpellDts = [ChampionSpellDto]()
//                        
//                        for (_, spellJSON) in json["spells"] {
//                            guard let name = spellJSON["name"].string else {return}
//                            let costValue = self.toInt(spellJSON["cost"])
//                            
//                            guard let cooldownBurnValue = spellJSON["cooldownBurn"].string else {return}
//                            let rangeValue = self.toDouble(spellJSON["range"])
//                            
//                            guard let descriptionValue = spellJSON["description"].string else {return}
//                            guard let fullValue = spellJSON["image"]["full"].string else {return}
//                            guard let groupValue = spellJSON["image"]["group"].string else {return}
//                            
//                            let altimages = ImageDto(full: fullValue, group: groupValue)
//                            
//                            let spellsChamp = ChampionSpellDto(name: name, altimages: altimages, cost: costValue, cooldownBurn: cooldownBurnValue, range: rangeValue, description: descriptionValue)
//                            
//                            listSpellDts.append(spellsChamp)
//                        }
//                        
//                        
//                        
//                        //---------------------------------------- xong spells
//                        
//                        let statsJSON = json["stats"]
//                        
//                        guard let hpValue = statsJSON["hp"].double else {return}
//                        guard let hpperlevelValue = statsJSON["hpperlevel"].double else {return}
//                        guard let hpregenValue = statsJSON["hpregen"].double else {return}
//                        guard let hpregenperlevelValue = statsJSON["hpregenperlevel"].double else {return}
//                        guard let armorValue = statsJSON["armor"].double else {return}
//                        guard let armorperlevelValue = statsJSON["armorperlevel"].double else {return}
//                        guard let attackdamageValue = statsJSON["attackdamage"].double else {return}
//                        guard let attackdamageperlevelValue = statsJSON["attackdamageperlevel"].double else {return}
//                        guard let spellblockValue = statsJSON["spellblock"].double else {return}
//                        guard let spellblockperlevelValue = statsJSON["spellblockperlevel"].double else {return}
//                        guard let movespeedValue = statsJSON["movespeed"].double else {return}
//                        
//                        let statsChamp = StatsDto(hp: hpValue, hpperlevel: hpperlevelValue,
//                                                  hpregen: hpregenValue, hpregenperlevel: hpregenperlevelValue,
//                                                  armor: armorValue, armorperlevel: armorperlevelValue,
//                                                  attackdamage: attackdamageValue, attackdamageperlevel: attackdamageperlevelValue,
//                                                  spellblock: spellblockValue, spellblockperlevel: spellblockperlevelValue,
//                                                  movespeed: movespeedValue)
//                        
//                        
//                        //---------------------------------------- xong spells
//                        
//                        
//                        guard let loreValue =  json["lore"].string else {return}
//                        
//                        var listSkin = [SkinDto]()
//                        for (_, skillJSON) in json["skins"] {
//                            guard let skillName = skillJSON["name"].string else {return}
//                            guard let skillNum = skillJSON["num"].int else {return}
//                            let skillValue = SkinDto(name: skillName, num: skillNum)
//                            listSkin.append(skillValue)
//                        }
//                        
//                        guard let keyValue = json["key"].string else {return}
//                        
//                        self.champ = ChampionDto(id: idValue, name: name, allytips: allytipsChamp, spells: listSpellDts, info: infoChamp, stats: statsChamp, tags: tagsChamp, skins: listSkin, title: titleChamp, lore: loreValue, key: keyValue)
//                        
//                        // download du lieu
//                        
//                        // self.downloadData(self.champ!)
//                        
//                        masterVC.champ = self.champ
//                        dispatch_async(dispatch_get_main_queue(), {
//                            self.navigationController?.pushViewController(masterVC, animated: true)
//                        })
//                        
//                    }
//                }
//            }
//            
//            }.resume()
//        
//    }
    
}
