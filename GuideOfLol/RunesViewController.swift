//
//  RunesViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/15/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON
class RunesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var MyTableView: UITableView!
    var runes = [Runes]()
    var rune: Runes?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.hidden = false
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
                            
                            
                            guard  let name = subjson["name"].string else {return}
                            
                            guard let description = subjson["description"].string else {return}
                            
                            
                            guard  let image = subjson["image"]["full"].string else{return}
                            
                            let rune = Runes(name: name, description: description, id: "1", image: image)
                            
                            self.runes.append(rune)
                            
                        }
                        
                    }
                }
                
                dispatch_async(dispatch_get_main_queue(),{self.MyTableView.reloadData()})
            }
            }.resume()
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return runes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomRuneCell
        if let name = runes[indexPath.row].name, _ = runes[indexPath.row].description, image = self.runes[indexPath.row].image {
            
            cell.nameRune.text = name
            
//            cell.Description.text = description
            
            cell.ImageRune.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(image, ofType: "")!)
            
        }
        
        return cell
    }
    
}