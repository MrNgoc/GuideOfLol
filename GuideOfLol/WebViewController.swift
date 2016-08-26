//
//  WebViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/9/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON
class WebViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    var videos = [Video]()
    
    @IBOutlet weak var MyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
        createGrandient()
        self.title = "Video mới cập nhật"
        
    }
    
    func getdata() {
        
        let urlRequest = NSMutableURLRequest(URL: NSURL(string:"https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&maxResults=10&playlistId=UUHKuLpFy9q8XDp0i9WNHkDw&key=AIzaSyBn-MXe-YQJsbJR3vOohb0rFndJ1PRNMQU")!)
        
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
                        
                        let jsonItem = json["items"]
                        print(jsonItem)
                        for (_ ,jsonSnippet) in jsonItem {
                            let title = jsonSnippet["snippet"]["title"].stringValue
                            
                            let urlImage = jsonSnippet["snippet"]["thumbnails"]["high"]["url"].stringValue
                            let videoId = jsonSnippet["snippet"]["resourceId"]["videoId"].stringValue
                            
                            let video = Video(title: title, image: urlImage, videoId: videoId)
                            self.videos.append(video)
                            
                        }
  
                    }
                    dispatch_async(dispatch_get_main_queue(),{self.MyTableView.reloadData()})
                }}
            
            }.resume()
        
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("youtube", forIndexPath: indexPath) as! CustomYoutubeCell
        cell.backgroundColor = UIColor.clearColor()
        if let title = videos[indexPath.row].title {
            cell.titlleVideo.text = title
        }
        if let url = videos[indexPath.row].image {
            let url = NSURL(string: url)
            let data = NSData(contentsOfURL: url!)
            cell.imageVideo.contentMode = .ScaleAspectFit
            cell.imageVideo.image = UIImage(data: data!)
            
        }
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let video1 = storyboard?.instantiateViewControllerWithIdentifier("video") as! VideoController
        video1.id = videos[indexPath.row].videoId
        navigationController?.pushViewController(video1, animated: true)
    }
    
    func createGrandient(){
        let bgGragdient = CAGradientLayer()
        bgGragdient.frame = view.frame
        
        bgGragdient.colors = [
            UIColor(red:0.51, green:0.64, blue:0.83, alpha:1.0).CGColor,
            UIColor(red:0.71, green:0.98, blue:1.00, alpha:1.0).CGColor]
        
        let startPoint = CGPoint.init(x: 0, y: 0)
        let endPoint =  CGPoint.init(x: 0.5, y: 0.5)
        
        bgGragdient.startPoint = startPoint
        bgGragdient.endPoint = endPoint
        
        view.layer.insertSublayer(bgGragdient,  atIndex: 0)
    }

    
}
