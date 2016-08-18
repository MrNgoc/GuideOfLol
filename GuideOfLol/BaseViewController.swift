//
//  Function.swift
//  GuideOfLol
//
//  Created by Le Ha Thanh on 8/15/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON


extension UISegmentedControl {
    func removeBorders() {
        setBackgroundImage(imageWithColor(backgroundColor!), forState: .Normal, barMetrics: .Default)
        setBackgroundImage(imageWithColor(tintColor!), forState: .Selected, barMetrics: .Default)
        setDividerImage(imageWithColor(UIColor.clearColor()), forLeftSegmentState: .Normal, rightSegmentState: .Normal, barMetrics: .Default)
    }
    
    // create a 1x1 image with this color
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRectMake(0.0, 0.0, 1.0, 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image
    }
}

class BaseViewController : UIViewController {
    
    var champions = [ChampionDto]()
    var champ : ChampionDto?
    var arrayChampion : NSArray?
    var array = [String]()
    
    func getData(url: String, collectionView : UICollectionView) {
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let session = NSURLSession.sharedSession()
        
        self.array = [String]()
        session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let responseHTTP = response as? NSHTTPURLResponse {
                    if responseHTTP.statusCode == 200 {
                        
                        let json = JSON(data:data!)
                        let data = json["data"]
                        
                        for (key,subJson):(String, JSON) in data {
                            let idChamp = subJson["id"].int
                            
                            let champion =  ChampionDto(id: idChamp!, name: key, image: String(key)+".png")
                            
                            self.champions.append(champion)
                            self.array.append(key)
                            
                        }
                        self.champions.sortInPlace({(cham : ChampionDto, cham2 : ChampionDto) -> Bool in return cham.name < cham2.name})
                        dispatch_async(dispatch_get_main_queue(),{collectionView.reloadData()})
                        self.arrayChampion = self.array
                       // self.arrayChampion = self.arrayChampion?.sortedArrayUsingSelector("compare:")
                    
                        
                    }
                }
            }
            
            }.resume()
        
    }
    
    
    func getDataOfChampion(idChamp : Int, masterVC : MasterTableVC) {
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion/\(idChamp)?locale=vn_VN&champData=all&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let error = error
            {
                print(error.localizedDescription)
            } else {
                if let responseHTTP = response as? NSHTTPURLResponse
                {
                    if responseHTTP.statusCode == 200
                    {
                        
                        let json = JSON(data:data!)
                        
                        // lay name + tag
                        guard let idValue = json["id"].int else {return}
                        guard let name = json["name"].string else { return }
                        
                        // lay title
                        guard let titleChamp = json["title"].string else {return}
                        
                        // lay allytips
                        let allytipsChamp = self.toString(json["allytips"])
                        let infoJSON  = json["info"]
                        
                        guard let attack = infoJSON["attack"].int else {return}
                        guard let defense = infoJSON["defense"].int else {return}
                        guard let magic = infoJSON["magic"].int else {return}
                        guard let difficulty = infoJSON["difficulty"].int else {return}
                        
                        let infoChamp = InfoDto(attack: attack, defense: defense, difficulty: difficulty, magic: magic)
                        let tagsChamp = self.toString(json["tags"])
                        
                        //---------------------------------------- xong overview
                        
                        var listSpellDts = [ChampionSpellDto]()
                        
                        for (_, spellJSON) in json["spells"] {
                            guard let name = spellJSON["name"].string else {return}
                            let costValue = self.toInt(spellJSON["cost"])
                            
                            guard let cooldownBurnValue = spellJSON["cooldownBurn"].string else {return}
                            let rangeValue = self.toDouble(spellJSON["range"])
                            
                            guard let descriptionValue = spellJSON["description"].string else {return}
                            guard let fullValue = spellJSON["image"]["full"].string else {return}
                            guard let groupValue = spellJSON["image"]["group"].string else {return}
                            
                            let altimages = ImageDto(full: fullValue, group: groupValue)
                            
                            let spellsChamp = ChampionSpellDto(name: name, altimages: altimages, cost: costValue, cooldownBurn: cooldownBurnValue, range: rangeValue, description: descriptionValue)
                            
                            listSpellDts.append(spellsChamp)
                        }
                        
                        
                        
                        //---------------------------------------- xong spells
                        
                        let statsJSON = json["stats"]
                        
                        guard let hpValue = statsJSON["hp"].double else {return}
                        guard let hpperlevelValue = statsJSON["hpperlevel"].double else {return}
                        guard let hpregenValue = statsJSON["hpregen"].double else {return}
                        guard let hpregenperlevelValue = statsJSON["hpregenperlevel"].double else {return}
                        guard let armorValue = statsJSON["armor"].double else {return}
                        guard let armorperlevelValue = statsJSON["armorperlevel"].double else {return}
                        guard let attackdamageValue = statsJSON["attackdamage"].double else {return}
                        guard let attackdamageperlevelValue = statsJSON["attackdamageperlevel"].double else {return}
                        guard let spellblockValue = statsJSON["spellblock"].double else {return}
                        guard let spellblockperlevelValue = statsJSON["spellblockperlevel"].double else {return}
                        guard let movespeedValue = statsJSON["movespeed"].double else {return}
                        
                        let statsChamp = StatsDto(hp: hpValue, hpperlevel: hpperlevelValue,
                                                  hpregen: hpregenValue, hpregenperlevel: hpregenperlevelValue,
                                                  armor: armorValue, armorperlevel: armorperlevelValue,
                                                  attackdamage: attackdamageValue, attackdamageperlevel: attackdamageperlevelValue,
                                                  spellblock: spellblockValue, spellblockperlevel: spellblockperlevelValue,
                                                  movespeed: movespeedValue)
                        
                        
                        //---------------------------------------- xong spells
                        
                        
                        guard let loreValue =  json["lore"].string else {return}
                        
                        var listSkin = [SkinDto]()
                        for (_, skillJSON) in json["skins"] {
                            guard let skillName = skillJSON["name"].string else {return}
                            guard let skillNum = skillJSON["num"].int else {return}
                            let skillValue = SkinDto(name: skillName, num: skillNum)
                            listSkin.append(skillValue)
                        }
                        
                        guard let keyValue = json["key"].string else {return}
                        
                        let imageValue = keyValue + ".png"
                        
                        self.champ = ChampionDto(id: idValue, name: name, allytips: allytipsChamp, spells: listSpellDts, info: infoChamp, stats: statsChamp, tags: tagsChamp, skins: listSkin, title: titleChamp, lore: loreValue, key: keyValue,image: imageValue)
                        
                        masterVC.champ = self.champ
                        dispatch_async(dispatch_get_main_queue(), {
                            self.navigationController?.pushViewController(masterVC, animated: true)
                        })
                        
                    }
                    
                    
                }
            }
            
            }.resume()
        
    }
    
    
    func toString(des: JSON) -> [String] {
        var text : [String] = []
        for i in des {
            if let string = i.1.string {
                text.append(string)
            }
        }
        return text
    }
    
    func toInt(des: JSON) -> [Int] {
        var numbers : [Int] = []
        for i in des {
            if let num = i.1.int {
                numbers.append(num)
            }
        }
        
        return numbers
    }
    
    func toDouble(des: JSON) -> [Double] {
        var text : [Double] = []
        for i in des {
            if let doubleNum = i.1.double {
                text.append(doubleNum)
            }
        }
        
        return text
    }
    
}
