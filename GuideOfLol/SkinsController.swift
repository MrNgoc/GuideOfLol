//
//  SkinsController.swift
//  GuideOfLol
//
//  Created by Admin on 8/8/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class SkinsController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var champ: ChampionDto?
    var skins = [SkinDto]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        skins = (champ?.skins)!
        
           }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return skins.count
        
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomUICollectionViewCell
        
        if let skinname = skins[indexPath.item].name {
            cell.skinName.text = skinname
            
            let a = "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/"
            
            if let champname = champ?.name, num = skins[indexPath.item].num {
                let urlFinalImage = a+champname+"_"+String(num)+".jpg"
                
                let url = NSURL(string: urlFinalImage)
                let data = NSData(contentsOfURL: url!)
                
                cell.skinImage.image = UIImage(data: data!)
                
            }
            
        }

        return cell
    }
    

}
