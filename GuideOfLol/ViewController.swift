//
//  ViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/2/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON


class ViewController: UIViewController {
    
    var champions = [ChampionDto]()
    
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string: "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?champData=image&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF")!)
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithRequest(urlRequest) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            }else{
                if let responseHTTP = response as? NSHTTPURLResponse{
                    if responseHTTP.statusCode == 200{
                        
                        let json = JSON(data:data!)
                        print(json)

//                        let data = json["data"]
////                        print(data)
//                        
//                        
//                        for (key,subJson):(String, JSON) in data {
//                            //Do something you want
//                            print(key)
//                            print(subJson)
//                            
//                            let champion = ChampionDto(id: 0, image: nil, name: key)
//                            
//                            self.champions.append(champion)
//                            
//                        }
//                        
//                        print(self.champions)
//                        
//                        for championName in self.champions{
//                            print("Champion name : \(championName.name)")
//                        }

                    }
                }
            }
            
        }.resume()
        
    }
    
}
