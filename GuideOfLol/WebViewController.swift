//
//  WebViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/9/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {
    
    @IBOutlet weak var myWebview: UIWebView!
    
    @IBOutlet weak var myIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getdata()
    }
    
    func getdata() {
        
        let url = NSURL(string:"https://www.youtube.com/user/GarenaVietnam")
        let urlRequest = NSURLRequest(URL: url!)
        self.myWebview.loadRequest(urlRequest)
        myIndicator.startAnimating()
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        myIndicator.hidden = true
        myIndicator.stopAnimating()
    }
    
}
