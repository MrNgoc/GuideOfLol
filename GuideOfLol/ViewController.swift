//
//  ViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/2/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON


class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var myCollection: UICollectionView!
    
    var champions = [ChampionDto]()
    var champ : ChampionDto?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        myCollection.backgroundColor = UIColor.whiteColor()
        
    }
    
    // lay anh + ten + id
    
    
    
    
    
    
    
    func getData() {
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?locale=vn_VN&champData=image&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let responseHTTP = response as? NSHTTPURLResponse {
                    if responseHTTP.statusCode == 200 {
                        
                        let json = JSON(data:data!)
                        let data = json["data"]
                        
                        let nameImage = "http://ddragon.leagueoflegends.com/cdn/6.12.1/img/champion/"
                        
                        for (key,subJson):(String, JSON) in data {
                            let idChamp = subJson["id"].int
                            let champion =  ChampionDto(id: idChamp!, name: key, image: nameImage+String(key)+".png")
                            self.champions.append(champion)
                            
                        }
                        
                        self.printChampions(self.champions)
                        
                        dispatch_async(dispatch_get_main_queue(),{self.myCollection.reloadData()})
                    }
                }
            }
            
            }.resume()
        
    }
           
    
    
    
    func printChampions(champs: [ChampionDto])
    {
        champions = champs
    }
    
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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let v1 = storyboard?.instantiateViewControllerWithIdentifier("Master") as? MasterTableVC
        if champions[indexPath.item].id! == 163 {
            print("eo co")
            return
        }
        
        getDataOfChampion(champions[indexPath.item].id!, masterVC: v1!)
        
        
    }
    
    
    
    func getDataOfChampion(idChamp : Int, masterVC : MasterTableVC) {

//        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion/\(idChamp)?champData=all&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
        
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
                        
                        for (key, spellJSON) in json["spells"] {
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
                        for (key, skillJSON) in json["skins"] {
                            guard let skillName = skillJSON["name"].string else {return}
                            guard let skillNum = skillJSON["num"].int else {return}
                            let skillValue = SkinDto(name: skillName, num: skillNum)
                            listSkin.append(skillValue)
                        }
                        
                        
                        
                        self.champ = ChampionDto(name: name, allytips: allytipsChamp, spells: listSpellDts, info: infoChamp, stats: statsChamp, tags: tagsChamp, skins: listSkin, title: titleChamp, lore: loreValue)
                        
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
