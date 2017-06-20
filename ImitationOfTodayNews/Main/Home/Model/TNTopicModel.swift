//
//  TNTopicModel.swift
//  ImitationOfTodayNews
//
//  Created by dukui on 2017/6/17.
//  Copyright © 2017年 dukui. All rights reserved.
//

import UIKit

class TNTopicModel: Reflect {
    var titleH: CGFloat = 0
    var titleW: CGFloat = 0
    var imageW: CGFloat = 0
    var imageH: CGFloat = 0
    var cellHeight: CGFloat = 0
    
    var abstract: String?
    
    var keywords: String?
    
    var title: NSString?
    
    var label: String?
    
    var article_alt_url: String?
    var article_url: String?
    var display_url: String?
    var share_url: String?
    var url: String?
    
    var item_id: Int?
    
    var tag_id: Int?
    var tag: String?
    
    var read_count: Int?
    var comment_count: Int?
    var repin_count: Int?
    var digg_count: Int?
    
    var publish_time: Int?
    
    var source: String?
    var source_avatar: String?
    var stick_label: String?
    
    var gallary_image_count: Int?
    var group_id: Int?
    
    var has_image: Bool?
    var has_m3u8_video: Bool?
    var has_mp4_video: Bool?
    var has_video: Bool?
    
    var video_detail_info: TNVideoDetailInfo?
    
    var video_style: Int?
    var video_duration: Int?
    var video_id: Int?
    
    // 点击 『x』 按钮，弹出框内容
    var filter_words = [TNFilterWord]()
    
    var image_list = [TNImageList]()
    var middle_image: TNMiddleImage?
    var large_image_list = [TNLargeImageList]()
    
    var behot_time: Int?
    
    var cell_flag: Int?
    var bury_count: Int?
    
    var article_type: Int?
    
    var cursor: Int?
    
    var media_info: TNMediaInfo?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "item_id" {
            self.item_id = value as? Int
        }
        if key == "tag_id" {
            self.tag_id = value as? Int
        }
        if key == "read_count" {
            self.read_count = value as? Int
        }
        if key == "comment_count" {
            self.comment_count = value as? Int
        }
        if key == "repin_count" {
            self.repin_count = value as? Int
        }
        if key == "digg_count" {
            self.digg_count = value as? Int
        }
        if key == "publish_time" {
            self.publish_time = value as? Int
        }
        if key == "gallary_image_count" {
            self.gallary_image_count = value as? Int
        }
        if key == "group_id" {
            self.group_id = value as? Int
        }
        if key == "video_style" {
            self.video_style = value as? Int
        }
        if key == "video_duration" {
            self.video_duration = value as? Int
        }
        if key == "video_id" {
            self.video_id = value as? Int
        }
        if key == "behot_time" {
            self.behot_time = value as? Int
        }
        if key == "cell_flag" {
            self.cell_flag = value as? Int
        }
        if key == "bury_count" {
            self.bury_count = value as? Int
        }
        if key == "article_type" {
            self.article_type = value as? Int
        }
        if key == "cursor" {
            self.cursor = value as? Int
        }
    }
}

class TNFilterWord: Reflect {
    var id: String?
    var is_selected: Bool?
    var name: String?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "is_selected" {
            self.is_selected = value as! NSNumber != 0
        }
    }
}

class TNImageList: Reflect {
    var height: Int?
    var width: Int?
    var url: String?
    var url_list: [[String:AnyObject]]?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "height" {
            self.height = value as? Int
        }
        if key == "width" {
            self.width = value as? Int
        }
    }
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "url_list" {
            if let jsonArr = value as? Array<Any> {
                for item in jsonArr {
                    if let jsonStr = item as? String {
                        let strData:Data = jsonStr.data(using: String.Encoding.utf8)!
                        do{
                            let dict = try JSONSerialization.jsonObject(with: strData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            self.url_list?.append(dict as! [String : AnyObject])
                        }catch {
                            print("url_list trans error")
                        }
                    }
                }
            }
        }else {
            super.setValue(value, forKey: key)
        }
    }
}

class TNMediaInfo: Reflect {
    var avatar_url: String?
    var name: String?
    var media_id: Int?
    var user_verified: Int?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "media_id" {
            self.media_id = value as? Int
        }
        if key == "user_verified" {
            self.user_verified = value as? Int
        }
    }
}

class TNMiddleImage: Reflect {
    var height: Int?
    var width: Int?
    var url: String?
    var url_list: [[String:AnyObject]]?
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "height" {
            self.height = value as? Int
        }
        if key == "width" {
            self.width = value as? Int
        }
    }
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "url_list" {
            if let jsonArr = value as? Array<Any> {
                for item in jsonArr {
                    if let jsonStr = item as? String {
                        let strData:Data = jsonStr.data(using: String.Encoding.utf8)!
                        do{
                            let dict = try JSONSerialization.jsonObject(with: strData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            self.url_list?.append(dict as! [String : AnyObject])
                        }catch {
                            print("url_list trans error")
                        }
                    }
                }
            }
        }else {
            super.setValue(value, forKey: key)
        }
    }

}

class TNLargeImageList: Reflect {
    var height: Int?
    var width: Int?
    var url: String?
    var url_list: [[String:AnyObject]]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "url_list" {
            if let jsonArr = value as? Array<Any> {
                for item in jsonArr {
                    if let jsonStr = item as? String {
                        let strData:Data = jsonStr.data(using: String.Encoding.utf8)!
                        do{
                            let dict = try JSONSerialization.jsonObject(with: strData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            self.url_list?.append(dict as! [String : AnyObject])
                        }catch {
                            print("url_list trans error")
                        }
                    }
                }
            }
        }else {
            super.setValue(value, forKey: key)
        }
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "height" {
            self.height = value as? Int
        }
        if key == "width" {
            self.width = value as? Int
        }
        if key == "url" {
            let stringValue = value as? String
            
            if (stringValue?.hasSuffix(".webp"))! {
                let range = stringValue?.range(of: ".webp")
                self.url = stringValue?.substring(to: range!.lowerBound)
            } else {
                self.url = stringValue
            }
        }
    }
}

class TNVideoDetailInfo: Reflect {
    var direct_play: Int?
    var group_flags: Int?
    var show_pgc_subscribe: Int?
    var video_id: String?
    var video_preloading_flag: Bool?
    var video_type: Int?
    var video_watch_count: Int?
    var video_watching_count: Int?
    var detail_video_large_image: TNDetailVideoLargeImage?
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "direct_play" {
            self.direct_play = value as? Int
        }
        if key == "group_flags" {
            self.group_flags = value as? Int
        }
        if key == "show_pgc_subscribe" {
            self.show_pgc_subscribe = value as? Int
        }
        if key == "video_type" {
            self.video_type = value as? Int
        }
        if key == "video_watch_count" {
            self.video_watch_count = value as? Int
        }
        if key == "video_watching_count" {
            self.video_watching_count = value as? Int
        }
    }
}

class TNDetailVideoLargeImage: Reflect {
    var height: Int?
    var width: Int?
    
    var url: String?
    
    var url_list : [[String:AnyObject]]?
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "url_list" {
            if let jsonArr = value as? Array<Any> {
                for item in jsonArr {
                    if let jsonStr = item as? String {
                        let strData:Data = jsonStr.data(using: String.Encoding.utf8)!
                        do{
                            let dict = try JSONSerialization.jsonObject(with: strData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            self.url_list?.append(dict as! [String : AnyObject])
                        }catch {
                            print("url_list trans error")
                        }
                    }
                }
            }
        }else {
            super.setValue(value, forKey: key)
        }
    }

    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "height" {
            self.height = value as? Int
        }
        if key == "width" {
            self.width = value as? Int
        }
    }
}
