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
    var tapedIndex : Int = 0
    weak var delegate : TopicViewDelegate?
    var itemWidth : CGFloat = 0
    var itemHeight : CGFloat = 0
    var needReLayout : Bool = true
    
    var topics : [TNHomeTopTitleModel]? {
        didSet {
            if needReLayout {
                let count = topics?.count
                if count! > 0 {
                    for index in 0..<count! {
                        let topic = topics![index]
                        let row = CGFloat(index/4)
                        let col = CGFloat(index%4)
                        let itemLabel = UILabel(frame: CGRect(x: kMargin + (kMargin + itemWidth) * col, y: kMargin + (kMargin + itemHeight) * row, width: itemWidth, height: itemHeight))
                        self.createLabel(topic, itemLabel, index)
                    }
                }
            }else {
                needReLayout = true
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        itemWidth = (self.width - kMargin * 5)/4.0
        itemHeight = ContentFont13.lineHeight + kMargin * 2
    }
    
    func createLabel(_ topic : TNHomeTopTitleModel,_ itemLabel : UILabel ,_ index : Int) {
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
            let closeImageView = UIImageView()
            closeImageView.image = UIImage(named: "add_channels_close_small_night_14x14_")
            closeImageView.contentMode = UIViewContentMode.center
            closeImageView.sizeToFit()
            closeImageView.width = closeImageView.width + 10
            closeImageView.height = closeImageView.height + 10
            closeImageView.center = CGPoint(x: itemLabel.right - closeImageView.width * 0.15, y: itemLabel.y + closeImageView.width * 0.15)
            self.addSubview(closeImageView)
            closeImageView.alpha = 0;
            closeImageView.tag = 1000 + index
            closeImageView.isUserInteractionEnabled = true
            closeImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemLabelCloseImageViewTaped(_:))))
        }
        itemLabel.isUserInteractionEnabled = true
        itemLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(itemLabelTaped(_:))))
        itemLabel.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(itemLabelLongPressed(_:))))
    }
    
    func hideCloseImageView(_ hide : Bool) {
        if !hide {
            for index in 0..<self.topics!.count {
                let itemCloseView = self.viewWithTag(1000 + index)
                itemCloseView?.alpha = 1
            }
        }else {
            for index in 0..<self.topics!.count {
                let itemCloseView = self.viewWithTag(1000 + index)
                itemCloseView?.alpha = 0
            }
        }

    }
    
    func getContentHeight(_ count : Int) -> CGFloat {
        let row = CGFloat((count - 1)/4)
        let offsetY = kMargin + (kMargin + itemHeight) * row + itemHeight
//        if let count = topics?.count {
//            let item = self.viewWithTag(count - 1)
//            return item!.bottom
//        }
//        return 0
        return offsetY
    }
    
    func getNewLastRect() -> CGRect {
        let count = self.topics?.count
        let row = CGFloat(count!/4)
        let col = CGFloat(count!%4)
        let rect = CGRect(x: kMargin + (kMargin + itemWidth) * col, y: kMargin + (kMargin + itemHeight) * row, width: itemWidth, height: itemHeight)
        return rect
    }
    
    func startSelectCommendTopicLabelMoveAction(_ newRect : CGRect,_ completion:@escaping(() -> ())) {
        let itemLabel = self.viewWithTag(tapedIndex)
        var oldRect = itemLabel?.frame
        UIView.animate(withDuration: 0.3, animations: {
            itemLabel?.frame = newRect
        }) { (finished) in
            itemLabel?.alpha = 0
            if finished {
                completion()
            }
            UIView.animate(withDuration: 0.3, animations: { 
                for index in (self.tapedIndex + 1)..<(self.topics?.count)! {
                    let item = self.viewWithTag(index)
                    let tempRect = item?.frame
                    item?.frame = oldRect!
                    oldRect = tempRect
                }
            }, completion: { (finished) in
                for index in (self.tapedIndex + 1)..<(self.topics?.count)! {
                    let item = self.viewWithTag(index)
                    let closeView = self.viewWithTag(1000 + index)
                    item?.tag = (item?.tag)! - 1
                    closeView?.tag = (closeView?.tag)! - 1
                }
                itemLabel?.tag = 10000 + self.tapedIndex
                itemLabel?.removeFromSuperview()
                self.needReLayout = false
                self.topics?.remove(at: self.tapedIndex)
            })
        }
    }
    
    func addNewItemLabel(_ newRect : CGRect,_ topic : TNHomeTopTitleModel) {
        if newRect == CGRect.zero {
//            self.topics?.append(topic)
            let row = CGFloat((self.topics?.count)!/4)
            let col = CGFloat((self.topics?.count)!%4)
            let itemLabel = UILabel(frame: CGRect(x: kMargin + (kMargin + itemWidth) * col, y: kMargin + (kMargin + itemHeight) * row, width: itemWidth, height: itemHeight))
            self.createLabel(topic, itemLabel, (self.topics?.count)!)
            needReLayout = false
            topics?.append(topic)
        }else {
            let itemLabel = UILabel(frame: newRect)
            needReLayout = false
            topics?.append(topic)
            let index = (self.topics?.count)! - 1
            self.createLabel(topic, itemLabel, index)
        }
    }
    
    func removeTopic(_ tag: Int) {
        let itemLabel = self.viewWithTag(tag)
        itemLabel?.alpha = 0
        let close = self.viewWithTag(1000 + tag)
        close?.alpha = 0
        var oldRect = itemLabel?.frame
        UIView.animate(withDuration: 0.3, animations: {
            for index in (tag + 1)..<(self.topics?.count)! {
                let item = self.viewWithTag(index)
                let closeView = self.viewWithTag(1000 + index)
                let tempRect = item?.frame
                item?.frame = oldRect!
                closeView?.center = CGPoint(x: (item?.right)! - (closeView?.width)! * 0.15, y: (item?.y)! + (closeView?.width)! * 0.15)
                oldRect = tempRect
            }
        }, completion: { (finished) in
            for index in (tag + 1)..<(self.topics?.count)! {
                let item = self.viewWithTag(index)
                let closeView = self.viewWithTag(1000 + index)
                item?.tag = (item?.tag)! - 1
                closeView?.tag = (closeView?.tag)! - 1
            }
            itemLabel?.tag = 10000 + self.tapedIndex
            itemLabel?.removeFromSuperview()
            close?.removeFromSuperview()
            self.needReLayout = false
            self.topics?.remove(at: tag)
        })
    }
    
    func itemLabelTaped(_ gesture : UIGestureRecognizer) {
        let itemLabel = gesture.view as! UILabel
        tapedIndex = itemLabel.tag
        self.delegate?.topicViewItemLabelTaped(itemLabel,self)
    }
    
    func itemLabelLongPressed(_ gesture : UIGestureRecognizer) {
        self.delegate?.topicViewItemLabelLongPress()
    }
    
    func itemLabelCloseImageViewTaped(_ gesture : UIGestureRecognizer) {
        let closeImageView = gesture.view as! UIImageView
        if let itemLabel = self.viewWithTag(closeImageView.tag - 1000) {
            self.delegate?.topicViewItemLabelClosed(itemLabel as! UILabel)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

protocol TopicViewDelegate : NSObjectProtocol {
    func topicViewItemLabelTaped(_ itemLabel : UILabel,_ topicView : TNTopicView)
    func topicViewItemLabelLongPress()
    func topicViewItemLabelClosed(_ itemLabel : UILabel)
}
