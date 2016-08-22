//    func download(){
//        var a = 0
//        for i in self.items {
//            print("\(++a)/\(count)")
//            self.x((i.image?.full)!)
//        }
//    }
//    
//    func x(text: String) {
//        if let dir = kDOCUMENT_DIRECTORY_PATH {
//            let pathToWrite = "\(dir)/items"
//            do {
//                try NSFileManager.defaultManager().createDirectoryAtPath(pathToWrite, withIntermediateDirectories: false, attributes: nil)
//            } catch let error as NSError {
//            }
//            
//            let url = NSURL(string: "http://ddragon.leagueoflegends.com/cdn/6.16.2/img/item/"+text)
//            
//            let data = NSData(contentsOfURL: url!)
//            writeDataToPath(data!, path: "\(pathToWrite)/\(text)")
//            
//        }
//    }





//import Foundation
////let kDOCUMENT_DIRECTORY_PATH = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .AllDomainsMask, true).first
//func downloadData(cham : [ChampionDto]){
//    //    for i in cham {
//    //        if let champSpell = i.spells, champKey = i.key, champID = i.id{
//    
//    //        let url = NSURL(string: "http://ddragon.leagueoflegends.com/cdn/6.16.2/img/champion/"+champKey+".png")
//    
//    //        let data = NSData(contentsOfURL: url!)
//    
//    
//    //        if let dir = kDOCUMENT_DIRECTORY_PATH {
//    //            let pathToWrite = "\(dir)/\(champKey)"
//    //            do {
//    //                try NSFileManager.defaultManager().createDirectoryAtPath(pathToWrite, withIntermediateDirectories: false, attributes: nil)
//    //            } catch let error as NSError {
//    //                print(error.localizedDescription)
//    //            }
//    //            writeDataToPath(data!, path: "\(pathToWrite)/\(champKey).png")
//    //            let pathToWrite1 = "\(dir)/\(champKey)/spells"
//    //            do {
//    //                try NSFileManager.defaultManager().createDirectoryAtPath(pathToWrite1, withIntermediateDirectories: false, attributes: nil)
//    //            } catch let error as NSError {
//    //                print(error.localizedDescription)
//    //            }
//    
//    //            if champKey != "Darius" {
//    //                for i in champSpell {
//    //                    let a = "http://ddragon.leagueoflegends.com/cdn/6.16.2/img/spell/"
//    //                    guard let url = i.altimages?.full else {return}
//    //                    let linkImageSpells = NSURL(string: a + url)
//    //                    let data1 = NSData(contentsOfURL: linkImageSpells!)
//    //                    if let image = i.altimages?.full {
//    //                        writeDataToPath(data1!, path: "\(pathToWrite1)/\(image)")
//    //                    }
//    //                }
//    //            }
//    //
//    //                let pathToWrite2 = "\(dir)/\(champKey)/skins"
//    //
//    //
//    //                do {
//    //                    try NSFileManager.defaultManager().createDirectoryAtPath(pathToWrite2, withIntermediateDirectories: false, attributes: nil)
//    //                } catch let error as NSError {
//    //                    print(error.localizedDescription)
//    //                }
//    //
//    //                for i in champSkins {
//    //                    let a = "http://ddragon.leagueoflegends.com/cdn/img/champion/splash/"
//    //                    guard let num = champSkins[1].num else {return}
//    //                    let urlFinalImage = NSURL(string: a+champKey+"_"+String(num)+".jpg")
//    //                    let data3 = NSData(contentsOfURL: urlFinalImage!)
//    //                    writeDataToPath(data3!, path: "\(pathToWrite2)/\(champKey)_\(num).jpg")
//    //                }
//    
//    //    }
//    //
//    //}
//    let dicData = NSMutableDictionary()
//    for i in cham {
//        if let champSpell = i.spells, champKey = i.key, champID = i.id{
//            
//            
//            let chamDATA = NSMutableDictionary()
//            
//            chamDATA.setValue(champKey, forKey: "key")
//            chamDATA.setValue("/\(champKey)/\(champKey).png", forKey: "image")
//            var count = 0
//            let spellList = NSMutableDictionary()
//            for i in champSpell {
//                spellList.setValue("\(i.altimages?.full)", forKey: "spell\(count++)")
//            }
//            count = 0
//            chamDATA.setValue(spellList, forKey: "spells")
//            dicData.setValue(chamDATA, forKey: "\(champID)")
//            //        id
//            //          key
//            //          image
//            //          spells
//            //              spell1
//            //              spell2
//            //              spell3
//            //              spell4
//        }
//    }
//    writeDataToPath(dicData, path: "\(kDOCUMENT_DIRECTORY_PATH)/ListChampion.plis")
//    
//}
//
//func writeDataToPath(data: NSDictionary, path: String) {
//    data.writeToFile(path, atomically: true)
//}
//
//
//func downloadData(cham : [ChampionDto]){
//    print("abc : \(cham.count)")
//    if let dir = kDOCUMENT_DIRECTORY_PATH {
//        let pathToWrite = "\(dir)"
//        do {
//            try NSFileManager.defaultManager().createDirectoryAtPath(pathToWrite, withIntermediateDirectories: false, attributes: nil)
//        } catch let error as NSError {
//            print(error.localizedDescription)
//        }
//        let dicData = NSMutableDictionary()
//        for i in cham {
//            print(i.id)
//            if let champSpell = i.spells, champKey = i.key, champID = i.id{
//                
//                let chamDATA = NSMutableDictionary()
//                
//                chamDATA.setValue("\(champID)", forKey: "id")
//                chamDATA.setValue("/\(champKey)/\(champKey).png", forKey: "image")
//                
//                var count = 0
//                let spellList = NSMutableDictionary()
//                for i in champSpell {
//                    if let spel = i.altimages?.full {
//                        spellList.setValue("\(spel)", forKey: "spell\(count++)")
//                    }
//                }
//                count = 0
//                chamDATA.setValue(spellList, forKey: "spells")
//                
//                dicData.setValue(chamDATA, forKey: "\(champKey)")
//                //        id
//                //          key
//                //          image
//                //          spells
//                //              spell1
//                //              spell2
//                //              spell3
//                //              spell4
//                
//            }
//        }
//        writeDataToPath(dicData, path: "\(pathToWrite)/ListChampion.plist")
//}
//
//
