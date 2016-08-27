//
//  DetailOfItem.swift
//  GuideOfLol
//
//  Created by Admin on 8/20/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON
class DetailOfItem: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var ImageItem: UIImageView!
    
    @IBOutlet weak var NameItem: UILabel!
    
    @IBOutlet weak var PriceItem: UILabel!
    
    @IBOutlet weak var desLabel: UILabel!
    
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    var numIn : Int?
    var numFrom : Int?
    var check : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numIn = item?.into.count
        numFrom = item?.from.count
        
        
        if let name = item?.name, id = item?.id, goldTotal = item?.gold?.total, description = item?.santizedDescription, sell = item?.gold?.sell  {
            NameItem.text = name
            
            let url = String(id) + ".png"
            self.ImageItem.layer.borderWidth = 1
            self.ImageItem.layer.borderColor = UIColor.yellowColor().CGColor
            
            
            self.ImageItem.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(url, ofType: "")!)
            
            PriceItem.text = "\(goldTotal) (\(sell))vàng "
            
            let text = "<font color=\"white\" size=\"4px\">" + description + "</font>"
            let attr = try! NSAttributedString(data: text.dataUsingEncoding(NSUnicodeStringEncoding,allowLossyConversion: true)!,options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
            
            desLabel.text = text
            
            desLabel.attributedText = attr
            
        }
        if check == 2 {
            self.navigationItem.hidesBackButton = true
            let newBackButton = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: UIBarButtonItemStyle.Bordered, target: self, action: #selector(back))
            self.navigationItem.leftBarButtonItem = newBackButton
        }
    }
    
    func back(sender: UIBarButtonItem) {
        let item = storyboard?.instantiateViewControllerWithIdentifier("item") as! ItemViewController
        navigationController?.pushViewController(item, animated: true)
        
        
    }
    
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        if numFrom == 0 && numIn == 0 {
            myCollectionView.hidden = true
            return 0
        } else if (numIn > 0 && numFrom > 0) {
            return 2
        }
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if numFrom > 0 && numIn > 0 {
            if section == 0 {
                return numFrom!
            } else {
                return numIn!
            }
        }
        //
        if numIn == 0 && numFrom > 0{
            if section == 0 {
                return numFrom!
            }
        } else
            if numFrom == 0 && numIn > 0 {
                if section == 0 {
                    return numIn!
                }
        }
        
        return 0
        
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomSuggestedItemCell1
        
        var nameimage = ""
        
        if indexPath.section == 0 {
            if numFrom > 0 {
                nameimage = (item?.from[indexPath.item])!
            } else if numFrom == 0 && numIn > 0{
                nameimage = (item?.into[indexPath.item])!
            }
        } else if indexPath.section == 1 {
            if numIn > 0 && numFrom > 0 {
                nameimage = (item?.into[indexPath.item])!
            }
        }
        switch nameimage {
        case "3717", "3718", "1303", "3632", "3722", "3725", "1318", "1317", "1323", "1302":
            nameimage = "3632"
        default:
            break
        }
        
        
        let urlImage = String(nameimage) + ".png"
        
        cell.ImageItem.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(urlImage, ofType: "")!)
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let sectionHeaderView = myCollectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "sectionHeader", forIndexPath: indexPath) as! SectionHeaderView1
        var text = ""
        
        if numFrom > 0 && numIn > 0 {
            if indexPath.section == 0 {
                text = "Built From"
            } else {
                text = "Builds into"
            }
        }
        
        if numIn == 0 && numFrom > 0{
            if indexPath.section == 0 { text = "Built From" }
        }
        
        if numFrom == 0 && numIn > 0 {
            if indexPath.section == 0 { text = "Builds into" }
        }
        
        
        sectionHeaderView.labelTitle!.text = text
        
        return sectionHeaderView
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if check == 2 {
            var id = ""
            if indexPath.section == 0 {
                if numFrom > 0 && numIn > 0 {
                    id = (item?.from[indexPath.item])!
                } else if numIn > 0 && numFrom == 0 {
                    id = (item?.into[indexPath.item])!
                } else if (numFrom > 0  && numIn == 0) {
                    id = (item?.from[indexPath.item])!
                }
            } else {
                if numFrom > 0 && numIn > 0 {
                    id = (item?.into[indexPath.item])!
                }
            }
            
            for i in items {
                if i.id == Int(id) {
                    let detail = self.storyboard?.instantiateViewControllerWithIdentifier("detail") as! DetailOfItem
                    detail.items = items
                    detail.item = i
                    detail.check = check
                    self.navigationController?.pushViewController(detail, animated: true)
                }
            }
        }
        
    }
    
}
