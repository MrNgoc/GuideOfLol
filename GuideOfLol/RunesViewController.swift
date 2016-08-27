//
//  RunesViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/15/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON
import BTNavigationDropdownMenu

class RunesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var MyTableView: UITableView!
    
    
    @IBOutlet weak var load: UIActivityIndicatorView!
    
    var runes = [Runes]()
    var rune: Runes?
    var filtered = [Runes]()
    let items = ["All", "Cấp 1", "Cấp 2", "Cấp 3", "Ngọc Xanh", "Ngọc Vàng", "Ngọc Tím", "Ngọc Đỏ"]
    var menuView: BTNavigationDropdownMenu!
    var indexValue = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.hidden = false
        self.navigationController!.navigationBar.tintColor = UIColor.orangeColor()
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.orangeColor(), NSFontAttributeName : UIFont(name : "HelveticaNeue-Bold" , size : 19)!]
        
        menuView = BTNavigationDropdownMenu(title: items[0], items: items)
        
        
        menuView.cellSeparatorColor = UIColor.cyanColor()
        menuView.cellHeight = 40
        menuView.cellTextLabelColor = UIColor.whiteColor()
        self.navigationItem.titleView = menuView
        
        menuView.didSelectItemAtIndexHandler = {[weak self] (indexPath: Int) -> () in
            
            switch indexPath {
            case 1, 2, 3:
                self?.indexValue = 1
                self!.filtered = self!.runes.filter({ (rune) -> Bool in
                    let tmp: NSString = (rune.rune?.tier)!
                    let range = tmp.rangeOfString(String(indexPath), options: NSStringCompareOptions.CaseInsensitiveSearch)
                    return range.location != NSNotFound
                })
                self!.MyTableView.reloadData()
            case 4, 5, 6, 7:
                let type = indexPath == 4 ? "blue" : indexPath == 5 ? "yellow" : indexPath == 6 ? "black" : "red"
                self?.indexValue = 1
                self!.filtered = self!.runes.filter({ (rune) -> Bool in
                    let tmp: NSString = (rune.rune?.type)!
                    let range = tmp.rangeOfString(type, options: NSStringCompareOptions.CaseInsensitiveSearch)
                    return range.location != NSNotFound
                })
                
            default:
                break
                
            }
            
            self!.MyTableView.reloadData()
            
        }
        
        
        getRune()
    }
    
    
    func getRune() {
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/rune?locale=vn_VN&runeListData=all&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let responseHTTP = response as? NSHTTPURLResponse {
                    if responseHTTP.statusCode == 200 {
                        
                        let json = JSON(data:data!)
                        let data = json["data"]
                        
                        for (_, subjson) in data {
                            
                            
                            let name = subjson["name"].stringValue
                            
                            let description = subjson["description"].stringValue
                            
                            let image = subjson["image"]["full"].stringValue
                            
                            let idValue = subjson["id"].stringValue
                            
                            let tierValue = subjson["rune"]["tier"].stringValue
                            let typeValue = subjson["rune"]["type"].stringValue
                            let runeValue = MetaDataDto(tier: tierValue, type: typeValue)
                            
                            let runeMeta = Runes(name: name, description: description, id: idValue, image: image, rune: runeValue)
                            
                            self.runes.append(runeMeta)
                            
                        }
                        
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(),{
                    self.MyTableView.reloadData()
                })
            }
            }.resume()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if indexValue == 1 {
            return filtered.count
        }
        return runes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomRuneCell
        if indexValue == 0 {
            
            if let name = runes[indexPath.row].name, description = runes[indexPath.row].description, image = runes[indexPath.row].image, tierValue = runes[indexPath.row].rune?.tier  {
                
                cell.nameRune.text = name
                
                cell.Description.text = description
                cell.tierLabel.text = "Bậc \(tierValue)"
                
                cell.ImageRune.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(image, ofType: "")!)
                
            }
        } else {
            if let name = filtered[indexPath.row].name, description = filtered[indexPath.row].description, image = self.filtered[indexPath.row].image,  tierValue = filtered[indexPath.row].rune?.tier {
                
                cell.nameRune.text = name
                
                cell.Description.text = description
                cell.tierLabel.text = "Bậc \(tierValue)"
                cell.ImageRune.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(image, ofType: "")!)
                
            }
            
        }
//        load.hidden = true
        load.stopAnimating()
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        print(runes[indexPath.row].rune!.type)
    }
    
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
