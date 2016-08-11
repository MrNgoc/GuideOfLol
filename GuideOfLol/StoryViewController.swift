//
//  StoryViewController.swift
//  GuideOfLol
//
//  Created by Le Ha Thanh on 8/8/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import UIKit

class StoryViewController: UIViewController {
    
    @IBOutlet weak var storyTextView: UITextView!
    var champ : ChampionDto?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard var storyValue = champ?.lore else {return}
        
        storyValue = "<font color=\"white\" size=\"4px\">" + storyValue + "</font>"
        let attr = try! NSAttributedString(data: storyValue.dataUsingEncoding(NSUnicodeStringEncoding,allowLossyConversion: true)!,options: [NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType], documentAttributes: nil)
        storyTextView.text = storyValue
        storyTextView.attributedText = attr
    }
    
}
