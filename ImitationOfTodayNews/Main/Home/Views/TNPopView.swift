//
//  TNPopView.swift
//  ImitationOfTodayNews
//
//  Created by dukui on 2017/6/23.
//  Copyright © 2017年 dukui. All rights reserved.
//

import UIKit

class TNPopView: UIView {
    
    
    var viewHeight : CGFloat = 0
    
    var filterWords : [TNFilterWord]? {
        didSet {
            for item in self.bgView.subviews {
                item.removeFromSuperview()
            }
            let offsetY : CGFloat = self.subTitleLabel.height + kHomeMargin + kMargin
            let itemBtnWidth : CGFloat = (self.width - 30 - 26 - kMargin) * 0.5
            let itemBtnHeight : CGFloat = ContentFont15.lineHeight + 5 + kMargin * 0.5
            let rowCount = ceilf((Float(CGFloat((filterWords?.count)!)/2.0)))
            
            let bgViewHeight = offsetY + itemBtnHeight * CGFloat(rowCount) + kMargin * 0.5
            viewHeight = bgViewHeight
            self.bgView.size = CGSize(width:self.width - 30,height:bgViewHeight)
            self.bgView.x = 15
            self.bgView.addSubview(titleLabel)
            self.bgView.addSubview(subTitleLabel)
            self.titleLabel.x = 13
            self.titleLabel.y = kHomeMargin
            self.subTitleLabel.centerY = self.titleLabel.centerY
            self.subTitleLabel.right = self.width - 30 - 13
            for index in 0..<filterWords!.count {
                let isLeft : Bool = ( index%2 == 0 )
                let word = filterWords![index]
                let itemBtn = UIButton(type: UIButtonType.custom)
                itemBtn.setTitle(word.name, for: UIControlState.normal)
                itemBtn.titleLabel?.font = ContentFont15
                itemBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
                itemBtn.frame = CGRect(x: isLeft ? 13 : 18 + itemBtnWidth, y: offsetY + itemBtnHeight * CGFloat(index/2), width: itemBtnWidth, height:ContentFont15.lineHeight + 5 )
                itemBtn.layer.cornerRadius = 3.0
                itemBtn.layer.masksToBounds = true
                itemBtn.layer.borderColor = UIColor.lightGray.cgColor
                itemBtn.layer.borderWidth = 0.6
                self.bgView.addSubview(itemBtn)
            }
        }
    }
    
    var btnCenter : CGPoint? {
        didSet {
            if viewHeight > self.height - btnCenter!.y {
                self.arrowImageView.transform = CGAffineTransform(scaleX: 1.0, y: -1.0)
                self.arrowImageView.bottom = btnCenter!.y - 8
                self.bgView.bottom = self.arrowImageView.y
            }else {
                self.arrowImageView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                self.arrowImageView.y = btnCenter!.y + 8
                self.bgView.y = self.arrowImageView.bottom
            }
            self.arrowImageView.right = btnCenter!.x
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = TNColor(0, 0, 0, 0.5)
        addSubview(arrowImageView)
        addSubview(bgView)
        self.isUserInteractionEnabled = true
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(bgViewTaped)))
        arrowImageView.x = 0
        arrowImageView.y = 0
        bgView.x = 0
        bgView.y = arrowImageView.bottom
    }
    
    func show() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.alpha = 1.0
        }
    }
    
    func bgViewTaped() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.alpha = 0;
        }
    }
    
    fileprivate lazy var arrowImageView : UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(named:"arrow_up_popup_textpage_36x8_")
        arrow.sizeToFit()
        return arrow
    }()
    
    fileprivate lazy var bgView : UIView = {
        let bg = UIView()
        bg.backgroundColor = UIColor.white
        bg.layer.cornerRadius = 10
        bg.layer.masksToBounds = true
        return bg
    }()
    
    fileprivate lazy var titleLabel : UILabel = {
        let title = UILabel()
        title.text = "可选理由，精准屏蔽"
        title.textColor = UIColor.black
        title.font = ContentFont16
        title.sizeToFit()
        return title
    }()
    
    fileprivate lazy var subTitleLabel : UILabel = {
        let subTitle = UILabel()
        subTitle.text = "不感兴趣"
        subTitle.backgroundColor = TNColor(246, 91, 93, 1.0)
        subTitle.font = ContentFont18
        subTitle.sizeToFit()
        subTitle.textColor = UIColor.white
        subTitle.textAlignment = NSTextAlignment.center
        subTitle.width = subTitle.width + 10
        subTitle.height = subTitle.height + 5
        subTitle.layer.cornerRadius = subTitle.height * 0.5
        subTitle.layer.masksToBounds = true
        return subTitle
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
