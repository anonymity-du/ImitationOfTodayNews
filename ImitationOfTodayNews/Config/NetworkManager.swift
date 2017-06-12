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
    func fetchHomeTitlesData(_ finished:@escaping (_ topTitles:[TNHomeTopTitleModel])->()) {
        let url = BASE_URL + "article/category/get_subscribed/v1/?"
        let params = ["device_id":device_id,
                      "aid":13,
                      "iid":IID] as [String:Any]
        Alamofire.request(url, method: .get, parameters: params )
        .responseJSON { (response) in
            guard response.result.isSuccess else {
                SVProgressHUD.showError(withStatus: "加载失败...")
                return
            }
            if let value = response.result.value {
                let json = JSON(value)
                let dataDict = json["data"].dictionary
                if let data = dataDict?["data"]?.arrayObject {
                    var topics = [TNHomeTopTitleModel]()
                    for dict in data {
                        let title = TNHomeTopTitleModel.parse(dict: dict as! NSDictionary)
                        topics.append(title)
                    }
                    finished(topics)
                }
            }
        }
    }
}
