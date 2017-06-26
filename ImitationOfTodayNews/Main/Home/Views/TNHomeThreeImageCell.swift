//
//  TNHomeThreeImageCell.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/6/21.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNHomeThreeImageCell: TNHomeGenericCell {

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
            
            for itemView in threeImageView.subviews {
                itemView.removeFromSuperview()
            }
            if model!.image_list.count > 0 {
                for index in 0..<model!.image_list.count {
                    if index >= 3 {
                        break
                    }
                    let itemImageView = UIImageView()
                    let imageList = model!.image_list[index]
                    let urlList = imageList.url_list![index]
                    if let urlString = urlList.url {
                        itemImageView.kf.setImage(with: URL(string:urlString)!)
                        itemImageView.frame = CGRect(x: (model!.imageW + 6) * CGFloat(index), y: 0, width: model!.imageW, height: model!.imageH)
                    }
                    itemImageView.backgroundColor = UIColor.lightGray
                    threeImageView.addSubview(itemImageView)
                }
            }
        }
    }
    
    override func closeBtnClicked() {
        self.delegate?.closeBtnClicked(self.model!,self,closeBtn)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(threeImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.width = model!.titleW
        titleLabel.height = model!.titleH
        
        threeImageView.x = kHomeMargin
        threeImageView.y = titleLabel.bottom + kMargin
        threeImageView.height = model!.imageH
        threeImageView.width = self.contentView.width - kHomeMargin * 2
    }
    
    fileprivate lazy var threeImageView : UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
