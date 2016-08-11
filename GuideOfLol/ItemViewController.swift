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
        
        getDataOfItem()
        
    }
    
    func getDataOfItem() {
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string:"https://global.api.pvp.net/api/lol/static-data/na/v1.2/item?itemListData=all&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
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
                            
                            let name = subjson["name"].string
                            let image = id+".png"
                            
                            let gold = subjson["gold"]["total"].stringValue
                            
                            let goldValue = GoldDto(total: gold, sell: "0")
                            
                            let imageUrl = ImageDtoItem(full: image)
                            if let id =  Int(id), name = name {
                                let item = ItemDto(id: id , image: imageUrl, gold: goldValue, name: name)
                                
                                self.items.append(item)
                            }
                            
                            self.printItems(self.items)
                            
                            dispatch_async(dispatch_get_main_queue(),{self.myTableView.reloadData()})
                            
                            
                        }
                    }
                }
                
            }
            }.resume()
    }
    
    
    func printItems(item: [ItemDto])
    {
        items = item
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomItemCell
        
        if let gold = (items[indexPath.row].gold?.total) {
            cell.goldItem.text = gold
        }
        
        let a = "http://ddragon.leagueoflegends.com/cdn/6.16.2/img/item/"
        
        cell.nameItem.text = items[indexPath.row].name
        
        if let nameimage = items[indexPath.row].image?.full {
            
            
            let urlImage = a + String(nameimage)
            
            
            let url = NSURL(string: urlImage)
            let data = NSData(contentsOfURL:url!)
            
            cell.imageItem.image = UIImage(data: data!)
            
        }
        
        
        return cell
    }
    
    
}
