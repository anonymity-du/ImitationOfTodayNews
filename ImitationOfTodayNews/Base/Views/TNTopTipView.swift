//
//  TNTopTipView.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/6/16.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNTopTipView: UIView {

    var title : String {
        set{
            titleLabel.text = newValue
            titleLabel.sizeToFit()
            titleLabel.centerX = self.width * 0.5
            titleLabel.centerY = self.height * 0.5
        }
        get{
            return titleLabel.text!
        }
    }
    
    fileprivate lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = TNColor(91, 162, 207, 1.0)
        label.font = ContentFont16
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = TNColor(215, 233, 246, 1.0)
        addSubview(titleLabel)
        titleLabel.centerX = self.width * 0.5
        titleLabel.centerY = self.height * 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
