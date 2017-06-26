//
//  TNHomeLargeImageCell.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/6/21.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNHomeLargeImageCell: TNHomeGenericCell {

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
            
            var urlString = String()
            
            if let videoDetailInfo = model?.video_detail_info {
                urlString = videoDetailInfo.detail_video_large_image!.url!
                let minute = Int(model!.video_duration! / 60)
                let second = model!.video_duration! % 60
                imageTimeLabel.text = String(format: "%02d:%02d", minute, second)
                playButton.isHidden = false
            } else {
                playButton.isHidden = true
                urlString = model!.large_image_list.first!.url!
                imageTimeLabel.text = "\(model!.gallary_image_count!)图"
            }
            imageTimeLabel.sizeToFit()
            imageTimeLabel.height = imageTimeLabel.height + 5
            imageTimeLabel.width = imageTimeLabel.width + 10
            largeImageView.size = CGSize(width: model!.imageW, height: model!.imageH)
            largeImageView.kf.setImage(with:URL(string: urlString)! )
        }
    }
    
    override func closeBtnClicked() {
        self.delegate?.closeBtnClicked(self.model!,self,closeBtn)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(largeImageView)
        largeImageView.addSubview(playButton)
        largeImageView.addSubview(imageTimeLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.width = model!.titleW
        titleLabel.height = model!.titleH
        
        largeImageView.y = titleLabel.bottom + kMargin
        largeImageView.x = kHomeMargin
        
        playButton.centerX = largeImageView.width * 0.5
        playButton.centerY = largeImageView.height * 0.5
        
        imageTimeLabel.right = largeImageView.width - kMargin
        imageTimeLabel.bottom = largeImageView.height - kMargin
    }
    
    fileprivate lazy var largeImageView : UIImageView = {
        let large = UIImageView()
        large.backgroundColor = UIColor.lightGray
        return large
    }()
    
    fileprivate lazy var playButton : UIButton = {
        let btn = UIButton(type: UIButtonType.custom)
        btn.setImage(UIImage(named: "playicon_video_60x60_"), for: UIControlState())
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(playButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    fileprivate lazy var imageTimeLabel : UILabel = {
        let time = UILabel()
        time.backgroundColor = TNColor(0, 0, 0, 0.5)
        time.textColor = UIColor.white
        time.font = ContentFont13
        time.layer.cornerRadius = ContentFont13.lineHeight * 0.5
        time.layer.masksToBounds = true
        time.textAlignment = NSTextAlignment.center
        return time
    }()
    
    func playButtonClicked() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
