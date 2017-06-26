//
//  TNHomeNoImageCell.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/6/20.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNHomeNoImageCell: TNHomeGenericCell {

    var model : TNTopicModel?{
        didSet{
            titleLabel.text = String(model!.title!)
            if let publishTime = model?.publish_time {
                timeLabel.text = NSString.changeDateTime(publishTime)
                timeLabel.sizeToFit()
            }
            
            if let sourceAvator = model?.source_avatar {
                nameLabel.text = model?.source
                nameLabel.sizeToFit()
                avatorImageView.setHeader(sourceAvator)
            }
            if let mediaInfo = model!.media_info {
                nameLabel.text = mediaInfo.name
                nameLabel.sizeToFit()
                avatorImageView.setHeader(mediaInfo.avatar_url!)
            }

            let commentCount = model!.comment_count!
            commentCount >= 10000 ? (commentLabel.text = "\(commentCount / 10000)万评论") : (commentLabel.text = "\(commentCount)评论")
            commentLabel.sizeToFit()

//            filterWords = newsTopic?.filter_words
            if let label = model?.label {
                stickLabel.text = label
                stickLabel.sizeToFit()
                stickLabel.isHidden = false
                closeBtn.isHidden = (label == "置顶") ? true : false
            }else {
                stickLabel.isHidden = true
                closeBtn.isHidden = false
            }
        }
    }
    
    override func closeBtnClicked() {
        self.delegate?.closeBtnClicked(self.model!,self,closeBtn)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: kHomeMargin, y: kHomeMargin, width: (model?.titleW)!, height: (model?.titleH)!)
    }
}
