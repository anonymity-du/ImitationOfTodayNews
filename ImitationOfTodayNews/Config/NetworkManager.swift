//
//  NetworkManager.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/6/8.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit
import Alamofire
import SVProgressHUD
import SwiftyJSON

class NetworkManager: NSObject {
    static let shareManager = NetworkManager()
    //获取首页的title
    func fetchHomeTitlesData(_ success:@escaping (_ topTitles:[TNHomeTopTitleModel])->(),_ failure:@escaping (_ error:Error)->()) {
        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let params = ["device_id":device_id,
                      "aid":13,
                      "iid":IID] as [String:Any]
        Alamofire.request(url, method: .get, parameters: params )
        .responseJSON { (response) in
            guard response.result.isSuccess else {
                failure(response.error!)
                return
            }
            var topics = [TNHomeTopTitleModel]()
            if let value = response.result.value {
                let json = JSON(value)
                let dataDict = json["data"].dictionary
                if let data = dataDict?["data"]?.arrayObject {
                    for dict in data {
                        let title = TNHomeTopTitleModel.parse(dict: dict as! NSDictionary)
                        topics.append(title)
                    }
                }
            }
            success(topics)
        }
    }
    func fetchRecommendArticleNumber(_ success: @escaping (_ count : Int)->(),_ failure: @escaping (_ error : Error)->()) {
        let url = BASE_URL + "2/article/v39/refresh_tip/"
        Alamofire.request(url, method: .get)
            .responseJSON {(response) in
                guard response.result.isSuccess else {
                    failure(response.error!)
                    return
                }
                var count : Int? = 0
                if let value = response.result.value {
                    let json = JSON(value)
                    let dataDict = json["data"].dictionary
                    count = dataDict!["count"]!.int
                }
                success(count!)
        }
    }
    func fetchHomeCategoryNews(_ category:String,_ lastTimeInterval:TimeInterval,_ success:@escaping ((_ topics:[TNTopicModel])->()),_ failure:@escaping (_ error:Error)->()) {
        let url = BASE_URL + "api/news/feed/v39/?"
        let params : [String : Any]
        if lastTimeInterval > 0 {
            params = ["device_id": device_id,
                      "category": category,
                      "iid": IID,
                      "last_refresh_sub_entrance_interval": lastTimeInterval] as [String : Any]
        }else {
            params = ["device_id": device_id,
                      "category": category,
                      "iid": IID]
        }
        Alamofire.request(url, method: .get, parameters: params)
            .responseJSON{ (response) in
                guard response.result.isSuccess else {
                    failure(response.error!)
                    return
                }
                var topics = [TNTopicModel]()
                if let value = response.result.value {
                    let json = JSON(value)
                    let datas = json["data"].array
                    for data in datas! {
                        let content = data["content"].stringValue
                        let contentData:Data = content.data(using: String.Encoding.utf8)!
                        do{
                            let dict = try JSONSerialization.jsonObject(with: contentData, options: JSONSerialization.ReadingOptions.allowFragments) as! NSDictionary
                            let topic = TNTopicModel.parse(dict: dict )
                            topics.append(topic)
                        }catch {
                            failure(response.error!)
                        }
                    }
                }
                success(topics)
        }
        
    }
}
