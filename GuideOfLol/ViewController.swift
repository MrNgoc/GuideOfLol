//
//  ViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/2/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var myCollection: UICollectionView!
    
    //    var champ : ChampionDto?
    var dictData : NSDictionary!
    var array : NSArray!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.hidden = false
        self.title = "Champions LOL"
        
        let path = NSBundle.mainBundle().pathForResource("ListChampion", ofType: "plist")!
        dictData = NSDictionary(contentsOfFile: path)!
        array = dictData.allKeys
        
        
        let urlString = "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?locale=vn_VN&champData=image&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF"
        
        getData(urlString, collectionView: myCollection)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return champions.count
    }
    
    
    var dem = 0
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CellItem
        
        if let imageName = champions[indexPath.item].image, name = champions[indexPath.item].name {
            cell.imageView.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(imageName, ofType: "")!)
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
    
    
    
}
