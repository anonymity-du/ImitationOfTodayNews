//
//  TNHomeTitleView.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/5/26.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNHomeTitleView: UIView {
    
    var hasAddIdentifier = false
    var titleArr = [TNHomeTopTitleModel]()
    var labelArr = [TNTitleLabel]()
    var selectedIndex : NSInteger = 0

    fileprivate lazy var scrollview:UIScrollView = {
        let scrollview = UIScrollView()
        scrollview.showsHorizontalScrollIndicator = false
        return scrollview
    }()
    
    fileprivate lazy var addButton : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named:"add_channel_titlbar_16x16_"), for: UIControlState.normal)
        btn.sizeToFit()
        btn.addTarget(self, action: #selector(addButtonClicked), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NetworkManager.shareManager.fetchHomeTitlesData { [weak self](topTitles) in
            print(topTitles)
            let recommend = TNHomeTopTitleModel()
            recommend.category = "__all__"
            recommend.name = "推荐"
            self!.titleArr.append(recommend)
            self!.titleArr += topTitles
            self!.setupUI()
        }
    }
    fileprivate func setupUI(){
        addSubview(scrollview)
        addSubview(addButton)
        scrollview.frame = CGRect(x: 0, y: 0, width: self.width - addButton.width, height: self.height)
        addButton.centerY = scrollview.centerY
        addButton.x =  scrollview.right
        
        self.createSubLabels()
    }
    
    fileprivate func createSubLabels(){
        var scrollViewWidth : CGFloat = 0
        
        for model in self.titleArr {
            let itemLabel = TNTitleLabel()
            itemLabel.text = model.name
            itemLabel.font = ContentFont17
            itemLabel.textColor = UIColor.white
            itemLabel.sizeToFit()
            itemLabel.width = itemLabel.width + 10
            itemLabel.height = itemLabel.height + 5
            itemLabel.textAlignment = NSTextAlignment.center
            self.labelArr.append(itemLabel)
            scrollview.addSubview(itemLabel)
            itemLabel.centerY = self.scrollview.height * 0.5
            itemLabel.x = scrollViewWidth;
            scrollViewWidth += itemLabel.width
            itemLabel.isUserInteractionEnabled = true
            itemLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(itemLabelTaped(_:))))
        }
        scrollview.contentSize = CGSize(width: scrollViewWidth, height: self.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func itemLabelTaped(_ gesture: UIGestureRecognizer) {
        print("item label taped")
        let itemLabel = gesture.view as? TNTitleLabel
        itemLabel?.currentScale = 1.1
    }
    
    func addButtonClicked() {
        print("add button clicked")
    }
}

class TNTitleLabel: UILabel {
    var currentScale : CGFloat = 1.0 {
        didSet {
            transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        }
    }
    
}
