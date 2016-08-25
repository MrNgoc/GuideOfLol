//
//  VideoController.swift
//  GuideOfLol
//
//  Created by Admin on 8/23/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import YouTubePlayer
import SwiftyJSON



class  VideoController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var MyTableView: UITableView!
    
    var id: String?
    var comments = [Comment]()
    
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let videoId = id {
            videoPlayer.loadVideoID(videoId)
            
        }
        
        
        getComment()
    }
    func getComment() {
        if let id = id {
            
            let urlRequest = NSMutableURLRequest(URL: NSURL(string:"https://www.googleapis.com/youtube/v3/commentThreads?part=snippet&videoId=\(id)&key=AIzaSyBn-MXe-YQJsbJR3vOohb0rFndJ1PRNMQU")!)
            
            let session = NSURLSession.sharedSession()
            
            session.dataTaskWithRequest(urlRequest) { (data, response, error) in
                if let error = error
                {
                    print(error.localizedDescription)
                } else {
                    if let responseHTTP = response as? NSHTTPURLResponse
                    {
                        if responseHTTP.statusCode == 200
                        {
                            
                            let json = JSON(data:data!)
                            
                            for(_,subjson) in json["items"] {
                                
                                let description = subjson["snippet"]["topLevelComment"]["snippet"]["textDisplay"].stringValue
                                let name = subjson["snippet"]["topLevelComment"]["snippet"]["authorDisplayName"].stringValue
                                
                                let image = subjson["snippet"]["topLevelComment"]["snippet"]["authorProfileImageUrl"].stringValue
                                
                                
                                let comment = Comment(name: name, image: image, description: description, title: "")
                                
                                
                                self.comments.append(comment)
                            }
                            
                        }
                        dispatch_async(dispatch_get_main_queue(),{
                            self.MyTableView.reloadData()
                        })
                        
                    }
                    
                    
                    
                }
                
                }.resume()
            
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
        
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            as! CustomCommentCell
        if let name = comments[indexPath.row].name, url = comments[indexPath.row].image, let description = comments[indexPath.row].description  {
            cell.name.text = name
            
            let url = NSURL(string: url)
            
            let data = NSData(contentsOfURL: url!)
            cell.imageprofile.image = UIImage(data: data!)

            cell.description1.text = description
            
        }
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
