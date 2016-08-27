//
//  Function.swift
//  GuideOfLol
//
//  Created by Le Ha Thanh on 8/15/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON

class BaseViewController : UIViewController {
    
    var champions = [ChampionDto]()
    var champ : ChampionDto?
    var arrayChampion : NSArray?
    var array = [String]()
    
    
    var items = [ItemDto]()
    var item : ItemDto?
    
    func getData(url: String, collectionView : UICollectionView, loadIndicator : UIActivityIndicatorView ) {
        
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
                            let idChamp = subJson["id"].intValue
                            
                            let champion =  ChampionDto(id: idChamp, name: key, image: String(key)+".png")
                            
                            self.champions.append(champion)
                            self.array.append(key)
                            
                        }
                        self.champions.sortInPlace({(cham : ChampionDto, cham2 : ChampionDto) -> Bool in return cham.name < cham2.name})
                        dispatch_async(dispatch_get_main_queue(),{
                            collectionView.reloadData()
                            loadIndicator.hidden = true

                            
                        })
                        self.arrayChampion = self.array
                        
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
                        let idValue = json["id"].intValue
                        let name = json["name"].stringValue
                        
                        // lay title
                        let titleChamp = json["title"].stringValue
                        
                        // lay allytips
                        let allytipsChamp = self.toString(json["allytips"])
                        let infoJSON  = json["info"]
                        
                        let attack = infoJSON["attack"].intValue
                        let defense = infoJSON["defense"].intValue
                        let magic = infoJSON["magic"].intValue
                        let difficulty = infoJSON["difficulty"].intValue
                        
                        let infoChamp = InfoDto(attack: attack, defense: defense, difficulty: difficulty, magic: magic)
                        let tagsChamp = self.toString(json["tags"])
                        
                        //---------------------------------------- xong overview
                        
                        var listSpellDts = [ChampionSpellDto]()
                        
                        for (_, spellJSON) in json["spells"] {
                            let name = spellJSON["name"].stringValue
                            let costValue = self.toDouble(spellJSON["cost"])
                            
                            let cooldownBurnValue = spellJSON["cooldownBurn"].stringValue
                            let rangeValue = self.toDouble(spellJSON["range"])
                            
                            let descriptionValue = spellJSON["description"].stringValue
                            let fullValue = spellJSON["image"]["full"].stringValue
                            let groupValue = spellJSON["image"]["group"].stringValue
                            
                            let altimages = ImageDto(full: fullValue, group: groupValue)
                            
                            let spellsChamp = ChampionSpellDto(name: name, altimages: altimages, cost: costValue, cooldownBurn: cooldownBurnValue, range: rangeValue, description: descriptionValue)
                            
                            listSpellDts.append(spellsChamp)
                        }
                        
                        
                        
                        //---------------------------------------- xong spells
                        
                        let statsJSON = json["stats"]
                        
                        let hpValue = statsJSON["hp"].doubleValue
                        let hpperlevelValue = statsJSON["hpperlevel"].doubleValue
                        let hpregenValue = statsJSON["hpregen"].doubleValue
                        let hpregenperlevelValue = statsJSON["hpregenperlevel"].doubleValue
                        let armorValue = statsJSON["armor"].doubleValue
                        let armorperlevelValue = statsJSON["armorperlevel"].doubleValue
                        let attackdamageValue = statsJSON["attackdamage"].doubleValue
                        let attackdamageperlevelValue = statsJSON["attackdamageperlevel"].doubleValue
                        let spellblockValue = statsJSON["spellblock"].doubleValue
                        let spellblockperlevelValue = statsJSON["spellblockperlevel"].doubleValue
                        let movespeedValue = statsJSON["movespeed"].doubleValue
                        
                        let statsChamp = StatsDto(hp: hpValue, hpperlevel: hpperlevelValue,
                                                  hpregen: hpregenValue, hpregenperlevel: hpregenperlevelValue,
                                                  armor: armorValue, armorperlevel: armorperlevelValue,
                                                  attackdamage: attackdamageValue, attackdamageperlevel: attackdamageperlevelValue,
                                                  spellblock: spellblockValue, spellblockperlevel: spellblockperlevelValue,
                                                  movespeed: movespeedValue)
                        
                        
                        //---------------------------------------- xong spells
                        
                        
                        let loreValue =  json["lore"].stringValue
                        
                        var listSkin = [SkinDto]()
                        for (_, skillJSON) in json["skins"] {
                            let skillName = skillJSON["name"].stringValue
                            let skillNum = skillJSON["num"].intValue
                            let skillValue = SkinDto(name: skillName, num: skillNum)
                            listSkin.append(skillValue)
                        }
                        
                        let keyValue = json["key"].stringValue
                        
                        let imageValue = keyValue + ".png"
                        
                        var recommendedValues = [RecommendedDto]()
                        for (_, subjson) in json["recommended"] {
                            let mapValue = subjson["map"].stringValue
                            
                            var blockValues = [BlockDto]()
                            
                            for (_,subjson1) in subjson["blocks"] {
                                
                                let typeValus = subjson1["type"].stringValue
                                var idItems = [String]()
                                for ( _ , subjson2) in subjson1["items"] {
                                    
                                    let idValues = subjson2["id"].intValue
                                    idItems.append(String(idValues))
                                }
                                let blockValue = BlockDto(items: idItems, type: typeValus)
                                blockValues.append(blockValue)
                            }
                            let re = RecommendedDto(blocks: blockValues, map: mapValue)
                            recommendedValues.append(re)
                        }
                        
                        
                        self.champ = ChampionDto(id: idValue, name: name, allytips: allytipsChamp, spells: listSpellDts, info: infoChamp, stats: statsChamp, tags: tagsChamp, skins: listSkin, title: titleChamp, lore: loreValue, key: keyValue,image: imageValue, recommended: recommendedValues)
                        
                        masterVC.champ = self.champ
                        dispatch_async(dispatch_get_main_queue(), {
                            self.navigationController?.pushViewController(masterVC, animated: true)
                        })
                        
                    }
                }
            }
            
            }.resume()
        
    }
    
    
    func getDataItems(myTableView : UITableView, load : UIActivityIndicatorView){
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string:"https://global.api.pvp.net/api/lol/static-data/na/v1.2/item?locale=vn_VN&itemListData=all&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                
            } else {
                if let responseHTTP = response as? NSHTTPURLResponse {
                    if responseHTTP.statusCode == 200
                    {
                        let json = JSON(data: data!)
                        
                        let jsonData = json["data"]
                        
                        
                        for (key, subjson) in jsonData {
                            let fromValue = self.toString(subjson["from"])
                            let intoValue = self.toString(subjson["into"])
                            
                            let gold = subjson["gold"]["total"].intValue
                            let sell = subjson["gold"]["sell"].intValue
                            let goldValue = GoldDto(total: gold, sell: sell)
                            
                            let groupValue = subjson["group"].stringValue
                            var image : String?
                            if key == "3717" || key == "3718" {
                                 image = "3632.png"
                            } else {
                                image = key + ".png"
                            }
                            let imageUrl = ImageDtoItem(full: image!)
                            
                            let nameValue = subjson["name"].stringValue
                            
                            
                            let sanitizedDescriptionValue = subjson["sanitizedDescription"].stringValue
                            
                            
                            
                            let tagsValue = self.toString(subjson["tags"])
                            
                            if let idValue = Int(key)  {
                                let item = ItemDto(from: fromValue, gold: goldValue, group: groupValue, id: idValue, image: imageUrl, name: nameValue, santizedDescription: sanitizedDescriptionValue, tags: tagsValue, into: intoValue)
                                
                                self.items.append(item)
                            }
                            
                        }
                        self.items.sortInPlace({(item1 : ItemDto, item2 : ItemDto) -> Bool in return item1.name < item2.name})
                        dispatch_async(dispatch_get_main_queue(),{myTableView.reloadData()
                            load.stopAnimating()

                            
                        })
                    }
                }
                
            }
            }.resume()
        
    }
    
    func getDataItems(){
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string:"https://global.api.pvp.net/api/lol/static-data/na/v1.2/item?locale=vn_VN&itemListData=all&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                
            } else {
                if let responseHTTP = response as? NSHTTPURLResponse {
                    if responseHTTP.statusCode == 200
                    {
                        let json = JSON(data: data!)
                        
                        let jsonData = json["data"]
                        
                        
                        for (key, subjson) in jsonData {
                            let fromValue = self.toString(subjson["from"])
                            let intoValue = self.toString(subjson["into"])
                            
                            let gold = subjson["gold"]["total"].intValue
                            let sell = subjson["gold"]["sell"].intValue
                            let goldValue = GoldDto(total: gold, sell: sell)
                            
                            let groupValue = subjson["group"].stringValue
                            var image : String?
                            if key == "3717" || key == "3718" {
                                image = "3632.png"
                            } else {
                                image = key + ".png"
                            }
                            let imageUrl = ImageDtoItem(full: image!)
                            
                            let nameValue = subjson["name"].stringValue
                            
                            let sanitizedDescriptionValue = subjson["sanitizedDescription"].stringValue

                            let tagsValue = self.toString(subjson["tags"])
                            
                            if let idValue = Int(key)  {
                                let item = ItemDto(from: fromValue, gold: goldValue, group: groupValue, id: idValue, image: imageUrl, name: nameValue, santizedDescription: sanitizedDescriptionValue, tags: tagsValue, into: intoValue)
                                
                                self.items.append(item)
                            }
                            
                        }
                        self.items.sortInPlace({(item1 : ItemDto, item2 : ItemDto) -> Bool in return item1.name < item2.name})
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
    
    
    func toDouble(des: JSON) -> [Double] {
        var text : [Double] = []
        for i in des {
            if let doubleNum = i.1.double {
                text.append(doubleNum)
            }
        }
        
        return text
    }
    
    func setTranparentForUINavigationBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.shadowImage = UIImage()   
    }
    
}
