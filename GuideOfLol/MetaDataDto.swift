//
//  MetaDataDto.swift
//  GuideOfLol
//
//  Created by Le Ha Thanh on 8/27/16.
//  Copyright © 2016 MrNgoc. All rights reserved.
//

class MetaDataDto {
    var tier: String?
    var type: String?
    
    init(tier: String, type : String) {
        self.tier = tier
        self.type = type
    }
}