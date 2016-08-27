//
//  ViewController.swift
//  GuideOfLol
//
//  Created by Admin on 8/2/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    @IBOutlet weak var loadDataIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myCollection: UICollectionView!
    
    @IBOutlet weak var searchController: UISearchBar!
    
    var searchActive: Bool = false
    
    var filtered: [ChampionDto] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataIndicator.hidden = false
        
        self.navigationController?.navigationBar.hidden = false
        self.title = "Champions LOL"
        let searchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: #selector(searchFunc))
        self.navigationItem.rightBarButtonItem = searchButton
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.whiteColor()
        
        searchController.delegate = self
        searchController.hidden = true
        
        
        let urlString = "https://global.api.pvp.net/api/lol/static-data/na/v1.2/champion?locale=vn_VN&champData=image&api_key=RGAPI-905251DD-5545-48D0-9598-0E601CA5E9AF"
        getData(urlString, collectionView: myCollection, loadIndicator: loadDataIndicator)
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        searchActive = false
    }
    
    func searchFunc(){
        UIView.animateWithDuration(0.5) {
            UIView.transitionWithView(self.searchController, duration: 0.5, options: UIViewAnimationOptions.TransitionFlipFromTop, animations: {
                self.searchController.hidden = !self.searchController.hidden
                }, completion: nil)
        }
        
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        searchActive = true;
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if (searchBar.text == ""){
            searchActive = false
        } else {
            searchActive = true
        }
        filtered = champions.filter({ (champion) -> Bool in
            let tmp: NSString = champion.name!
            let range = tmp.rangeOfString(searchText, options: NSStringCompareOptions.CaseInsensitiveSearch)
            return range.location != NSNotFound
        })
        
        self.myCollection.reloadData()
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (searchActive) {
            return filtered.count
        }
        return champions.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CellItem
        if (searchActive) {
            
            
            if let imageName = filtered[indexPath.item].image, name = filtered[indexPath.item].name {
                cell.nameLabel.text = name
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.imageView.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(imageName, ofType: "")!)
                        
                    })
                }
                
            }
            
            
        } else  {
            
            if let imageName = champions[indexPath.item].image, name = champions[indexPath.item].name {
                
                cell.nameLabel.text = name
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)) {
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        cell.imageView.image =  UIImage(contentsOfFile: NSBundle.mainBundle().pathForResource(imageName, ofType: "")!)
                        
                    })
                }
            }
        }
        loadDataIndicator.hidden = true
        loadDataIndicator.stopAnimating()
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = (view.bounds.width - 40) / 4.0
        return CGSizeMake(width, width)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let v1 = storyboard?.instantiateViewControllerWithIdentifier("Master") as? MasterTableVC
        
        if searchActive {
            getDataOfChampion(filtered[indexPath.item].id!, masterVC: v1!)
        }else {
            
            getDataOfChampion(champions[indexPath.item].id!, masterVC: v1!)
            
        }
        
        v1?.items = items
    }
    
    
    
}
