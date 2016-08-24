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
                            
                            for(key,subjson) in json["items"] {
                                
                                guard let description = (subjson["snippet"]["topLevelComment"]["snippet"]["textDisplay"].string) else {return}
                                guard  let name = subjson["snippet"]["topLevelComment"]["snippet"]["authorDisplayName"].string else {return}
                                
                                guard  let image = subjson["snippet"]["topLevelComment"]["snippet"]["authorProfileImageUrl"].string else {return}
                                
                                
                                let comment = Comment(name: name, image: image
                                    , description: description, title: "")
                                
                                
                                self.comments.append(comment)
                            }
                            
                        }
                        dispatch_async(dispatch_get_main_queue(),{
                            self.MyTableView.reloadData()
                            print(self.comments.count)
                        })
                        
                    }
                    
                    
                    
                }
                
                }.resume()
            
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(comments.count)
        return comments.count
        
        
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
            as! CustomCommentCell
        if let name = comments[indexPath.row].name {
            cell.name.text = name
            
        }
        if let description = comments[indexPath.row].description {
            cell.description1.text = description
            
        }
        if let url = comments[indexPath.row].image {
            let url = NSURL(string: url)
            
            let data = NSData(contentsOfURL: url!)
            cell.imageprofile.image = UIImage(data: data!)
            
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
