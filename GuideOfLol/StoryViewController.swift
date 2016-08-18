//
//  StoryViewController.swift
//  GuideOfLol
//
//  Created by Le Ha Thanh on 8/8/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON
class StoryViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var typeArray = [String]()
    
    @IBOutlet weak var MycollectionView: UICollectionView!
    
    @IBOutlet weak var storyTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        MycollectionView.backgroundColor = UIColor.whiteColor()
        // MycollectionView.registerClass(SectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "sectionHeader")
        if let recommendedCham = champ?.recommended {
                        for re in recommendedCham {
            //                print("_____________")

        print(re.map)
            }
            
        }
            
                }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let sectionHeaderView = MycollectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "sectionHeader", forIndexPath: indexPath) as! SectionHeaderView
        
        sectionHeaderView.labelTitle!.text = (champ?.recommended![3].blocks![indexPath.section].type)
        
        
        
        return sectionHeaderView
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return (champ?.recommended![3].blocks?.count)!
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (champ?.recommended![3].blocks![section].items!.count)!
        
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomSuggestedItemCell
        
        
        let a = "http://ddragon.leagueoflegends.com/cdn/6.16.2/img/item/"
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0))  {
            if let nameimage = self.champ?.recommended![3].blocks![indexPath.section].items![indexPath.item] {
                
                
                let urlImage = a + String(nameimage) + ".png"
                
                
                let url = NSURL(string: urlImage)
                let data = NSData(contentsOfURL:url!)
                
                cell.ImageItem.image = UIImage(data: data!)
                
            }
        }
        return cell
    }
    
    
    
}

