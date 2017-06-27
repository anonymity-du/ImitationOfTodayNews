//
//  TNTopicView.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/6/27.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNTopicView: UIView {
    
    var isMine : Bool = true
    
    var topics : [TNHomeTopTitleModel]? {
        didSet {
            let count = topics?.count
            let itemWidth : CGFloat = (self.width - kMargin * 5)/4.0
            let itemHeight : CGFloat = ContentFont13.lineHeight + kMargin * 2
            if count! > 0 {
                for index in 0..<count! {
                    let topic = topics![index]
                    let row = CGFloat(index/4)
                    let col = CGFloat(index%4)
                    let itemLabel = UILabel(frame: CGRect(x: kMargin + (kMargin + itemWidth) * col, y: kMargin + (kMargin + itemHeight) * row, width: itemWidth, height: itemHeight))
                    itemLabel.tag = index
                    itemLabel.text = isMine ? topic.name : "+\(topic.name!)"
                    if (itemLabel.text?.characters.count)! > 3 {
                        itemLabel.font = ContentFont13
                    }else {
                        itemLabel.font = ContentFont16
                    }
                    itemLabel.textAlignment = NSTextAlignment.center
                    itemLabel.layer.cornerRadius = 3.0
                    itemLabel.layer.masksToBounds = true
                    self.addSubview(itemLabel)
                    itemLabel.backgroundColor = isMine ? TNColor(245, 245, 245, 1.0) : UIColor.white
                    if !isMine {
                        itemLabel.layer.borderColor = TNColor(235, 235, 235, 1.0).cgColor
                        itemLabel.layer.borderWidth = 0.5
                        itemLabel.textColor = UIColor.black
                    }else {
                        itemLabel.textColor = (index == 0) ? TNColor(210, 63, 66, 1.0) : UIColor.black
                    }
                    itemLabel.isUserInteractionEnabled = true
                    itemLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemLabelTaped(_:))))
                    itemLabel.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(itemLabelLongPressed(_:))))
                }
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
    }
    
    func getContentHeight() -> CGFloat {
        if let count = topics?.count {
            let item = self.viewWithTag(count - 1)
            return item!.bottom
        }
        return 0
    }
    
    func itemLabelTaped(_ gesture : UIGestureRecognizer) {
        
    }
    
    func itemLabelLongPressed(_ gesture : UIGestureRecognizer) {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
