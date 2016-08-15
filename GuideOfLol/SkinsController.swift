//
//  SkinsController.swift
//  GuideOfLol
//
//  Created by Admin on 8/8/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class SkinsController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var pageControler: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var frontScrollViews : [UIScrollView] = []
    var first = false
    var currentPage = 0
    
    var champ: ChampionDto?
    var skins = [SkinDto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        skins = (champ?.skins)!
        pageControler.currentPage = currentPage
        pageControler.numberOfPages = skins.count
        scrollView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        if (!first){
            first = true
            let pagesScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * CGFloat(skins.count), 0)
            scrollView.contentOffset = CGPointMake(CGFloat(currentPage) * scrollView.frame.size.width, 0)
            
            let a = "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/"
            var imgView : UIImageView!
            
            for i in 0 ..< skins.count {
                if let champKey = champ?.key
                    , num = skins[i].num , nameSkins = skins[i].name{
                    let urlFinalImage = a+champKey+"_"+String(num)+".jpg"
                    let url = NSURL(string: urlFinalImage)
                    let height = (view.frame.height * 51 * 20 / (408 * 71))
                    
                    let nameLabel = UILabel(frame : CGRectMake(0, 0, view.frame.width , height))
                    nameLabel.textColor = UIColor.whiteColor()
                    nameLabel.textAlignment = NSTextAlignment.Center
                    nameLabel.text = nameSkins

                    nameLabel.frame = CGRectMake(0, scrollView.frame.height - height, view.frame.width , height)
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                        let data = NSData(contentsOfURL: url!)
                        dispatch_async(dispatch_get_main_queue(), {
                            imgView = UIImageView(image: UIImage(data: data!))
                            
                            imgView.frame = CGRectMake(0, 0, self.scrollView.frame.size.width,
                                self.scrollView.frame.size.height)
                            imgView.contentMode = .ScaleAspectFit
                            let frontScrollView = UIScrollView(frame: CGRectMake(
                                CGFloat(i) * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width,
                                self.scrollView.frame.size.height
                                ))
                            
                            frontScrollView.delegate = self
                            frontScrollView.contentSize = imgView.bounds.size
                            frontScrollView.addSubview(imgView)
                            frontScrollView.addSubview(nameLabel)
                            self.frontScrollViews.append(frontScrollView)
                            self.scrollView.addSubview(frontScrollView)
                            
                        })
                    }
                    
                    
                }
            }
        }
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        let pageWidth = scrollView.frame.size.width
        let page = Int(floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth)+1)
        if (currentPage != page) {
            currentPage = page
            
        }
        pageControler.currentPage = page
        
    }
    
    
    @IBAction func onChange(sender: AnyObject) {
        scrollView.contentOffset = CGPointMake(CGFloat(pageControler.currentPage) * scrollView.frame.size.width, 0)
    }
    
}
