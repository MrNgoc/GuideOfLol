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
    var count : Int? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        
        
    }
    
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
                            //
                            let image = subJson["image"]["full"]
                            //
                            let champion =  ChampionDto(id: 0, image: nameImage+String(image), name: key)
                            self.champions.append(champion)
                            
                        }
                        
                        self.count = self.champions.count
                        self.printChampions(self.champions)
                        
                        dispatch_async(dispatch_get_main_queue(), { 
                            self.myCollection.reloadData()
                        })
                        
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
        print(champions.count)
//        return champions.count
        return 3
    }
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CellItem
//        var imageURL = champions[indexPath.item].image
        var imageURL : String = "http://ddragon.leagueoflegends.com/cdn/6.12.1/img/champion/TwistedFate.png"
        print(imageURL)
        let url = NSURL(string: imageURL)
        let data = NSData(contentsOfURL: url!)
       cell.imageView.image = UIImage(data: data!)
        cell.backgroundColor = UIColor.whiteColor()
        return cell
    }
}
