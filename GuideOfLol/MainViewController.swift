//
//  MainViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/9/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON

let kDOCUMENT_DIRECTORY_PATH = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .AllDomainsMask, true).first

class MainViewController: BaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    var arrayInt = [Int]()
    
    var dictData : NSDictionary!
    var arrayKeys : NSArray!
    
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

                        for (key,subJson):(String, JSON) in data {
                            if let idChamp = subJson["id"].int {
                                for ids in self.arrayInt where ids == idChamp {
                                    
                                    let champion = ChampionDto(id: idChamp, name: key, image: String(key)+".png")
                                    
                                    self.champions.append(champion)
                                }
                            }
                        }
                        
                        dispatch_async(dispatch_get_main_queue(),{self.mycollectionview.reloadData()})
                    }
                }
            }
            
            }.resume()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.mycollectionview.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return champions.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomMainCell
        
        if let imageURL = champions[indexPath.item].image {
             cell.ImageFreeChampion.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(imageURL, ofType: "")!)
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let v1 = storyboard?.instantiateViewControllerWithIdentifier("Master") as? MasterTableVC
        getDataOfChampion(champions[indexPath.item].id!, masterVC: v1!)
        
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
    
    @IBAction func RunesAction(sender: AnyObject) {
        let item = storyboard?.instantiateViewControllerWithIdentifier("rune") as! RunesViewController
        navigationController?.pushViewController(item, animated: true)
        
        
    }
}
