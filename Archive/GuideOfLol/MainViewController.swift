//
//  MainViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/9/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON

class MainViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var arrayInt = [Int]()
    var champions = [ChampionDto]()
    var champ : ChampionDto?
    
    @IBOutlet weak var mycollectionview: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        getId()
        mycollectionview.backgroundColor = UIColor.clearColor()
        self.getData()
        self.navigationController?.navigationBar.hidden = true
    }
    
    func getId() {
        let urlRequest = NSMutableURLRequest(URL: NSURL(string:"https://na.api.pvp.net/api/lol/na/v1.2/champion?freeToPlay=true&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let responseHTTP = response as? NSHTTPURLResponse {
                    if responseHTTP.statusCode == 200 {
                        
                        let json = JSON(data:data!)
                        
                        let jsonid = json["champions"]
                        
                        for (_, subid) in jsonid {
                            let id = subid["id"].intValue
                            
                            self.arrayInt.append(id)
                            
                        }
                    }
                    //self.getData()
                }
                
            }
            
            }.resume()
        
    }
    
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
                        
                        let nameImage = "http://ddragon.leagueoflegends.com/cdn/6.16.2/img/champion/"
                        
                        for (key,subJson):(String, JSON) in data {
                            if let idChamp = subJson["id"].int {
                                for ids in self.arrayInt where ids == idChamp {
                                    
                                    let champion = ChampionDto(id: idChamp, name: key, image: nameImage+String(key)+".png")
                                    
                                    self.champions.append(champion)
                                }
                            }
                        }
                        
                        self.printChampions(self.champions)
                        dispatch_async(dispatch_get_main_queue(),{self.mycollectionview.reloadData()})
                    }
                }
            }
            
            }.resume()
        
    }
    func printChampions(champs: [ChampionDto])
    {
        
        champions = champs
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.mycollectionview.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return champions.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomMainCell
        
        let imageURL = champions[indexPath.item].image
        
        let url = NSURL(string: imageURL!)
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
            let data = NSData(contentsOfURL: url!)
            
            dispatch_async(dispatch_get_main_queue(), {
                cell.ImageFreeChampion.image = UIImage(data: data!)
            })
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print(champions[indexPath.row].id)
    }
    
    @IBAction func actionWeb(sender: AnyObject) {
        
        let web = storyboard?.instantiateViewControllerWithIdentifier("webview") as! WebViewController
        navigationController?.pushViewController(web, animated: true)
        
    }
    
    @IBAction func ChampionAction(sender: AnyObject) {
        let champion = storyboard?.instantiateViewControllerWithIdentifier("champion") as!ViewController
        navigationController?.pushViewController(champion, animated: true)
        
    }
    
    @IBAction func ItemAction(sender: UIButton) {
        let item = storyboard?.instantiateViewControllerWithIdentifier("item") as!ItemViewController
        navigationController?.pushViewController(item, animated: true)
        
    }
    
 
}
