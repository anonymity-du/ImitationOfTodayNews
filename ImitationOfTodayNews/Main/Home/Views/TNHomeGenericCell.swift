//
//  TNHomeGenericCell.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/6/20.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNHomeGenericCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func createUI() {
        addSubview(titleLabel)
        addSubview(avatorImageView)
        addSubview(nameLabel)
        addSubview(commentLabel)
        addSubview(timeLabel)
        addSubview(stickLabel)
        addSubview(closeBtn)
    }
    
    func closeBtnClicked() {
        //implemented in subclass
    }
    
    lazy var titleLabel : UILabel = {
        let titleLabel : UILabel = UILabel()
        titleLabel.font = ContentFont17
        titleLabel.textColor = UIColor.black
        titleLabel.numberOfLines = 0
        return titleLabel
    }()
    
    lazy var avatorImageView : UIImageView = {
        let avator = UIImageView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
        avator.layer.cornerRadius = 8;
        avator.layer.masksToBounds = true
        return avator
    }()
    
    lazy var nameLabel : UILabel = {
        let nameLabel : UILabel = UILabel()
        nameLabel.font = ContentFont12
        nameLabel.textColor = UIColor.lightGray
        return nameLabel
    }()
    
    lazy var commentLabel : UILabel = {
        let commentLabel : UILabel = UILabel()
        commentLabel.font = ContentFont12
        commentLabel.textColor = UIColor.lightGray
        return commentLabel
    }()
    
    lazy var timeLabel : UILabel = {
        let timeLabel : UILabel = UILabel()
        timeLabel.font = ContentFont12
        timeLabel.textColor = UIColor.lightGray
        return timeLabel
    }()
    
    lazy var stickLabel : UILabel = {
        let stickLabel : UILabel = UILabel()
        stickLabel.isHidden = true
        stickLabel.layer.cornerRadius = 3.0
        stickLabel.font = ContentFont12
        stickLabel.textColor = TNColor(241, 91, 94, 1.0)
        stickLabel.layer.borderColor = TNColor(241, 91, 94, 1.0).cgColor
        stickLabel.layer.borderWidth = 0.5
        return stickLabel
    }()
    
    lazy var closeBtn : UIButton = {
        let close = UIButton()
        close.setImage(UIImage(named:"add_textpage_17x12_"), for: UIControlState.normal)
        close.sizeToFit()
        close.contentMode = UIViewContentMode.center
        close.width = close.width + 10
        close.height = close.height + 5
        close.addTarget(self, action: #selector(closeBtnClicked), for: UIControlEvents.touchUpInside)
        return close
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.x = kHomeMargin
        titleLabel.y = kHomeMargin
        
        avatorImageView.x = titleLabel.x
        avatorImageView.bottom = self.contentView.height - kHomeMargin
        
        nameLabel.centerY = avatorImageView.centerY
        nameLabel.x = avatorImageView.right + 5
        
        commentLabel.x = nameLabel.right + 5
        commentLabel.centerY = nameLabel.centerY
        
        timeLabel.x = commentLabel.right + 5
        timeLabel.centerY = commentLabel.centerY
        
        stickLabel.x = timeLabel.right + 5
        stickLabel.centerY = timeLabel.centerY
        
        closeBtn.right = self.contentView.right - kHomeMargin
        closeBtn.centerY = avatorImageView.centerY
    }
}
