//
//  TNHomeTopTitleModel.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/6/7.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNHomeTopTitleModel: Reflect {
    var category: String?
    var web_url: String?
    var concern_id: String?
    var icon_url: String?
    var name: String?
    var isSelected : Bool = true
    var flags: Int?
    var type: Int?
    var tip_new : Int?
    var default_add : Int?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "flags" {
            self.flags = value as? Int
        }
        if key == "type" {
            self.type = value as? Int
        }
        if key == "tip_new" {
            self.tip_new = value as? Int
        }
        if key == "default_add" {
            self.default_add = value as? Int
        }
    }
}
