//
//  StoryViewController.swift
//  GuideOfLol
//
//  Created by Le Ha Thanh on 8/8/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON

class  StoryViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIPickerViewDataSource,UIPickerViewDelegate {
    var typeArray = [String]()
    
    @IBOutlet weak var MycollectionView: UICollectionView!
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var mapIndex = 0
    var itemsInfo = [ItemInformation]()
    
    var pickerData = ["Mới chơi - The Crystal Scar", "Vực Gió Hú", "Nhà chính thất thủ", "Khu Rừng Quỷ Dị", "Summoner’s Rift",  "Mới chơi - Summoner’s Rift", "Vực Gió Hú XH"]
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let sectionHeaderView = MycollectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "sectionHeader", forIndexPath: indexPath) as! SectionHeaderView
        if var typeValue = champ?.recommended![mapIndex].blocks![indexPath.section].type {
            
            switch typeValue {
            case "starting", "beginner_Starter", "beginner_starter", "1)buystarteritems":
                typeValue = "Trang bị khởi đầu"
            case "early":
                typeValue = "Trang bị lên đầu tiên"
            case "essential":
                typeValue = "Trang bị cần thiết"
            case "offensive":
                typeValue = "Trang bị tấn công"
            case "defensive":
                typeValue = "Trang bị phòng ngự"
            case "support":
                typeValue = "Trang bị hỗ trợ"
            case "situational":
                typeValue = "Trang bị thay thế"
            case "consumables":
                typeValue = "Trang bị hồi phục"
            case "siegeDefense":
                typeValue = "Khí cụ phòng ngự"
            case "siegeOffense":
                typeValue = "Khí cụ tấn công"
            case "standard":
                typeValue = "Đồ chuẩn"
            case "beginner_Advanced", "beginner_advanced":
                typeValue = "Trang bị tiếp theo"
            case "beginner_MovementSpeed", "beginner_movementSpeed", "beginner_movementspeed":
                typeValue = "Trang bị tăng tốc"
            case "beginner_LegendaryItem", "beginner_legendaryItem", "beginner_legendaryitem":
                typeValue = "Trang bị trấn phái"
            case "beginner_MoreLegendaryItems", "beginner_moreLegendaryItems", "beginner_morelegendaryitems" :
                typeValue = "Trang bị cuối cùng"
            default:
                break
            }
            
            sectionHeaderView.labelTitle!.text = typeValue
            
        }
        return sectionHeaderView
    }
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return (champ?.recommended![mapIndex].blocks?.count)!
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (champ?.recommended![mapIndex].blocks![section].items!.count)!
        
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomSuggestedItemCell
        
        if var nameimage = self.champ?.recommended![mapIndex].blocks![indexPath.section].items![indexPath.item] {
            switch nameimage {
            case "2044":
                nameimage = "3632"
            default:
                break
            }
            let urlImage = String(nameimage) + ".png"
            
            cell.ImageItem.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(urlImage, ofType: "")!)
            

            let urlRequest = NSMutableURLRequest(URL: NSURL(string:"https://global.api.pvp.net/api/lol/static-data/na/v1.2/item/\(nameimage)?locale=vn_VN&itemData=all&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
            let session = NSURLSession.sharedSession()
            
            session.dataTaskWithRequest(urlRequest) { (data, response, error) in
                if let error = error {
                    print(error.localizedDescription)
                    
                } else {
                    if let responseHTTP = response as? NSHTTPURLResponse {
                        if responseHTTP.statusCode == 200 {
                            let json = JSON(data: data!)
                            let name = json["name"].stringValue
                            
                            let description = json["sanitizedDescription"].stringValue
                            
                            let gold = json["gold"]["total"].stringValue
                            
                            let information = ItemInformation(id: nameimage, description: description, name: name, gold: gold)
                            
                            self.itemsInfo.append(information)
                        }
                    }
                }
                
                
                }.resume()

        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if let id = self.champ?.recommended![mapIndex].blocks![indexPath.section].items![indexPath.item] {
            for i in items {
                if i.id == Int(id) {
                    let detail = self.storyboard?.instantiateViewControllerWithIdentifier("detail") as! DetailOfItem
                    detail.items = items
                    detail.item = i
                    detail.check = 1
                    self.navigationController?.pushViewController(detail, animated: true)
                    
                }
            }
        }
        
    }
    
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        mapIndex = row
        itemsInfo = [ItemInformation]()
        MycollectionView.reloadData()
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let titleData = pickerData[row]
        
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "HelveticaNeue-Bold", size: 14)!,NSForegroundColorAttributeName:UIColor.whiteColor()])
        pickerLabel.attributedText = myTitle
        pickerLabel.textAlignment = .Center
        return pickerLabel
    }
}

