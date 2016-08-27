//
//  ItemViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/10/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON

class ItemViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var myTableView: UITableView!
    
    @IBOutlet weak var loadData: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Items"
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        getDataItems(myTableView, load: loadData)
        
        self.navigationItem.hidesBackButton = true
        loadData.hidden = false
        loadData.startAnimating()
    
        
        let newBackButton = UIBarButtonItem(image: UIImage(named: "BackIcon"), style: UIBarButtonItemStyle.Bordered, target: self, action: #selector(back))
        
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    func back(sender: UIBarButtonItem) {
        let main = storyboard?.instantiateViewControllerWithIdentifier("main") as!MainViewController
        navigationController?.pushViewController(main, animated: false)
        
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! CustomItemCell
        
        if let nameimage = items[indexPath.row].image?.full , gold = (items[indexPath.row].gold?.total) {
            
            cell.goldItem.text = String(gold)
            
            cell.nameItem.text = items[indexPath.row].name
            
            cell.imageItem.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(nameimage, ofType: "")!)
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let detail = self.storyboard?.instantiateViewControllerWithIdentifier("detail") as! DetailOfItem
        detail.items = items
        detail.item = items[indexPath.item]
        detail.check = 2
        self.navigationController?.pushViewController(detail, animated: true)
        
    }
    
    
}
