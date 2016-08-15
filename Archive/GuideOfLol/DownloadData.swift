//
//  DownloadData.swift
//  GuideOfLol
//
//  Created by Le Ha Thanh on 8/12/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

import Foundation

func downloadData(cham : ChampionDto){
    
    if let champSpell = cham.spells, champKey = cham.key, champSkins = cham.skins {
        print(champKey)
        //            if (champName != "Kled" && champName != "Taliyah"){
        
        let url = NSURL(string: "http://ddragon.leagueoflegends.com/cdn/6.16.2/img/champion/"+champKey+".png")
        
        let data = NSData(contentsOfURL: url!)
        
        
        if let dir = kDOCUMENT_DIRECTORY_PATH {
            let pathToWrite = "\(dir)/\(champKey)"
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(pathToWrite, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            writeDataToPath(data!, path: "\(pathToWrite)/\(champKey).png")
            let pathToWrite1 = "\(dir)/\(champKey)/spells"
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(pathToWrite1, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            if champKey != "Darius" {
                for i in champSpell {
                    let a = "http://ddragon.leagueoflegends.com/cdn/6.16.2/img/spell/"
                    guard let url = i.altimages?.full else {return}
                    let linkImageSpells = NSURL(string: a + url)
                    let data1 = NSData(contentsOfURL: linkImageSpells!)
                    if let image = i.altimages?.full {
                        writeDataToPath(data1!, path: "\(pathToWrite1)/\(image)")
                    }
                }
            }
            //
            //                let pathToWrite2 = "\(dir)/\(champKey)/skins"
            //
            //
            //                do {
            //                    try NSFileManager.defaultManager().createDirectoryAtPath(pathToWrite2, withIntermediateDirectories: false, attributes: nil)
            //                } catch let error as NSError {
            //                    print(error.localizedDescription)
            //                }
            //
            //                for i in champSkins {
            //                    let a = "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/"
            //                    guard let num = champSkins[1].num else {return}
            //                    let urlFinalImage = NSURL(string: a+champKey+"_"+String(num)+".jpg")
            //                    let data3 = NSData(contentsOfURL: urlFinalImage!)
            //                    writeDataToPath(data3!, path: "\(pathToWrite2)/\(champKey)_\(num).jpg")
            //                }
            
        }
        
    }
    
}

//    }

func writeDataToPath(data: NSData, path: String) {
    data.writeToFile(path, atomically: true)
}
