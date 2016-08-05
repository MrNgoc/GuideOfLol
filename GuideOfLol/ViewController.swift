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
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?champData=image&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let responseHTTP = response as? NSHTTPURLResponse{
                    if responseHTTP.statusCode == 200 {
                        
                        let json = JSON(data:data!)
                        let data = json["data"]

                        var nameImage = "http://ddragon.leagueoflegends.com/cdn/6.12.1/img/champion/"

                        for (key,subJson):(String, JSON) in data {
                            let idChamp = subJson["id"].intValue
                            let champion =  ChampionDto(id: idChamp, name: key, image: nameImage+String(key)+".png")
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
        // print(champions.count)
        return champions.count
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CellItem
        
        let imageURL = champions[indexPath.item].image
        
        //        var imageURL = champions[indexPath.item].nameImg
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
        
        getDataOfChampion(champions[indexPath.item].id!, masterVC: v1!)
    }
    
    func getDataOfChampion(idChamp : Int, masterVC : MasterTableVC) {
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
                        let allytipsChamp = self.toString(json["allytips"])
                        
                        
                        
                        
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
                        
                        self.champ = ChampionDto(title: titleChamp, tags: tag, info: infoChamp, allytips: allytipsChamp)
                        
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
            text.append(i.1.string!)
        }
        
        return text
    }
    

}
