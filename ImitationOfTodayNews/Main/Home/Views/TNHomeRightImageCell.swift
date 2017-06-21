//
//  TNHomeRightImageCell.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/6/21.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNHomeRightImageCell: TNHomeGenericCell {

    var model : TNTopicModel? {
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
            }else {
                stickLabel.isHidden = true
            }
            
            let urlString = model!.middle_image?.url
            rightImageView.size = CGSize(width: model!.imageW, height: model!.imageH)
            rightImageView.kf.setImage(with:URL(string: urlString!)! )
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(rightImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.width = model!.titleW
        titleLabel.height = model!.titleH
        
        rightImageView.right = self.contentView.width - kHomeMargin
        rightImageView.y = kHomeMargin
        
        closeBtn.right = rightImageView.x - kMargin
    }
    
    fileprivate lazy var rightImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.lightGray
        return imageView
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
