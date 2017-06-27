//
//  TNHomeTitleView.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/5/26.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit
import SVProgressHUD

class TNHomeTitleView: UIView {
    
    var hasAddIdentifier = false
    var titleArr = [TNHomeTopTitleModel]()
    var labelArr = [TNTitleLabel]()
    var itemWidthArr = [CGFloat]()
    
    var selectedIndex : NSInteger = 0

    var addBtnClickedClosure : (() -> ())?
    var topicSelectedClosure : ((_ titleLabel: TNTitleLabel) -> ())?
    var titleViewDidInitClosure : ((_ titleArr: [TNHomeTopTitleModel]) -> ())?
    
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
        
        NetworkManager.shareManager.fetchHomeTitlesData({ [weak self](topTitles) in
//            print(topTitles)
            let recommend = TNHomeTopTitleModel()
            recommend.category = "__all__"
            recommend.name = "推荐"
            self!.titleArr.append(recommend)
            self!.titleArr += topTitles
            self!.setupUI()
        }) { (error) in
            SVProgressHUD.showError(withStatus: "加载失败...")
        }
    }
    fileprivate func setupUI(){
        addSubview(scrollview)
        addSubview(addButton)
        scrollview.frame = CGRect(x: 0, y: 0, width: self.width - addButton.width, height: self.height)
        addButton.centerY = scrollview.centerY
        addButton.x =  scrollview.right
        
        self.createSubLabels()
        titleViewDidInitClosure?(titleArr)
    }
    
    fileprivate func createSubLabels(){
        var scrollViewWidth : CGFloat = 0
        var index = 0;
        
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
            itemLabel.tag = index;
            index = index + 1;
            scrollview.addSubview(itemLabel)
            itemLabel.centerY = self.scrollview.height * 0.5
            itemLabel.x = scrollViewWidth;
            scrollViewWidth += itemLabel.width
            itemWidthArr.append(itemLabel.width)
            itemLabel.isUserInteractionEnabled = true
            itemLabel.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(itemLabelTaped(_:))))
        }
        let firstItemLabel = labelArr.first
        firstItemLabel?.currentScale = 1.2;
        scrollview.contentSize = CGSize(width: scrollViewWidth, height: self.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func itemLabelTaped(_ gesture: UIGestureRecognizer) {
        print("item label taped")
        let itemLabel = gesture.view as? TNTitleLabel
        topicSelectedClosure?(itemLabel!)
        titleAdjustScrollView(selectedIndex, (itemLabel?.tag)!)
    }
    
    func titleAdjustScrollView(_ oldIndex : Int,_ newIndex: Int) {
        let originLabel = labelArr[oldIndex]
        originLabel.currentScale = 1.0
        selectedIndex = newIndex
        
        var offsetCenterX : CGFloat = 0
        for index in 0..<selectedIndex {
            offsetCenterX = offsetCenterX + itemWidthArr[index]
        }
        offsetCenterX += itemWidthArr[selectedIndex] * 0.5;
        var offsetX = offsetCenterX - scrollview.width * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        if offsetX > scrollview.contentSize.width - scrollview.width {
            offsetX = scrollview.contentSize.width - scrollview.width
        }
        let itemLabel = labelArr[newIndex]
        scrollview.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
        itemLabel.currentScale = 1.2
    }
    
    func addButtonClicked() {
        print("add button clicked")
        addBtnClickedClosure?()
    }
}

class TNTitleLabel: UILabel {
    var currentScale : CGFloat = 1.0 {
        didSet {
            transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        }
    }
    
}
