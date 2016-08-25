//
//  ItemViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/10/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    var items = [ItemDto]()
    var item: ItemDto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Items"
         self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        getDataOfItem()
        
    }
    
    func getDataOfItem() {
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string:"https://global.api.pvp.net/api/lol/static-data/na/v1.2/item?locale=vn_VN&itemListData=all&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                
            } else {
                if let responseHTTP = response as? NSHTTPURLResponse {
                    if responseHTTP.statusCode == 200 {
                        let json = JSON(data: data!)
                        
                        let jsonData = json["data"]
                        
                        
                        for (id, subjson) in jsonData {
                            let fromValue = self.toString(subjson["from"])
                            
                            let gold = subjson["gold"]["total"].stringValue
                            let goldValue = GoldDto(total: gold, sell: "0")
                            
                            let groupValue = subjson["group"].stringValue
                            
                            let image = id+".png"
                            let imageUrl = ImageDtoItem(full: image)
                            
                            let name = subjson["name"].string
                            
                            let santizedDescriptionValue = subjson["santizedDescription"].stringValue
                            
                            if let id =  Int(id), name = name {
                                let item = ItemDto(from: fromValue, gold: goldValue, group: groupValue, id: id, image: imageUrl, name: name, santizedDescription: santizedDescriptionValue)
                                
                                self.items.append(item)
                            }
                            
                        }
                        self.items.sortInPlace({(item1 : ItemDto, item2 : ItemDto) -> Bool in return item1.name < item2.name})
                        dispatch_async(dispatch_get_main_queue(),{self.myTableView.reloadData()})
                    }
                }
                
            }
            }.resume()
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomItemCell
        
        if let nameimage = items[indexPath.row].image?.full , var gold = (items[indexPath.row].gold?.total) {
            
            if gold == "\0" && gold == ""{
                gold = "0"
            }
            
            cell.goldItem.text = gold
            
            cell.nameItem.text = items[indexPath.row].name
            
            cell.imageItem.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(nameimage, ofType: "")!)
            
        }
        
        return cell
    }
    
    func toString(des: JSON) -> [String] {
        var text : [String] = []
        for i in des {
            if let string = i.1.string {
                text.append(string)
            }
        }
        return text
    }
    
    
}
