//
//  UIImageView+Extension.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/6/20.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setHeader(_ url: String) {
        let placeholder = UIImage(named: "home_head_default_29x29_")
        self.kf.setImage(with: URL(string: url), placeholder: placeholder, options: nil, progressBlock: nil, completionHandler: { (image, error, cacheType, imageURL) in
            self.image = (image == nil) ? placeholder : image
        })
    }
}
