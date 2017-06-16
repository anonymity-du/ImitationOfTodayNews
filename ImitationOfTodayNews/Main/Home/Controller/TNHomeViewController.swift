//
//  TNHomeViewController.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/5/25.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNHomeViewController: UIViewController , UIScrollViewDelegate{

    var topicTitles = [TNHomeTopTitleModel]()
    var oldIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        // 设置导航栏属性
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = TNColor(210, 63, 66, 1.0)
        // 设置 titleView
        navigationItem.titleView = titleView
        // 添加滚动视图
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        
        showRecommendCountTips()
        
        setTitleViewClosure()
        // Do any additional setup after loading the view.
    }

    fileprivate func setTitleViewClosure() {
        titleView.addBtnClickedClosure = {
            
        }
        titleView.topicSelectedClosure = { [weak self] (titleLabel) in
            self!.scrollView.setContentOffset(CGPoint(x:CGFloat(titleLabel.tag) * self!.scrollView.width,y:0), animated: true)
        }
        titleView.titleViewDidInitClosure = { [weak self] (titleArr) in
            self!.topicTitles = titleArr
            _ = Reflect.save(obj: titleArr as AnyObject, name: "top_title", duration: 0)
            var colorNumber : CGFloat = 10;
            for topTitle in titleArr {
                let topicVC = UIViewController()
                topicVC.title = topTitle.name
                topicVC.view.backgroundColor = UIColor.init(red: colorNumber/255.0, green: colorNumber/255.0, blue: 0, alpha: 1.0)
                colorNumber = colorNumber + 10
                self!.addChildViewController(topicVC)
            }
            self!.addSubVCView()
            self!.scrollView.contentSize = CGSize.init(width: self!.view.width * CGFloat(titleArr.count), height: self!.scrollView.height)
        }
    }
    
    func showRecommendCountTips() {
        NetworkManager.shareManager.fetchRecommendArticleNumber { [weak self](count) in
            self?.tipView.title = (count == 0) ? "暂无更新，请稍等一会儿" : "今日头条推荐有\(count)条更新"
            self?.tipView.transform = CGAffineTransform(scaleX: 0.1, y: 1.0)
            self?.tipView.alpha = 1.0
            UIView.animate(withDuration: 0.25, animations: {
                self?.tipView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0 )
            }, completion: { (finished) in
                if finished {
                    UIView.animate(withDuration: 0.25, delay: 3, options: UIViewAnimationOptions.curveEaseIn, animations: {
                        self?.tipView.alpha = 0;
                    })
                }
            })
        }
    }
    
    fileprivate lazy var titleView : TNHomeTitleView = {
        let titleView = TNHomeTitleView(frame:CGRect.init(x: 0, y: 0, width: self.view.width, height: NavigationTitleHeight))
        
        return titleView
    }()
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 64, width: self.view.width, height: self.view.height - 64 - 44)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.white
        return scrollView;
    }()
    
    fileprivate lazy var tipView : TNTopTipView = {
        let tipView = TNTopTipView(frame:CGRect.init(x: 0, y: 44, width: self.view.width, height: 35))
        self.navigationController?.navigationBar.insertSubview(tipView,at:0)
        return tipView
    }()
    
    fileprivate func addSubVCView() {
        let index = Int(scrollView.contentOffset.x/scrollView.width)
        let vc = self.childViewControllers[index]
        if !scrollView.subviews.contains(vc.view) {
            vc.view.x = scrollView.contentOffset.x
            vc.view.y = 0
            vc.view.height = scrollView.height
            vc.view.width = scrollView.width
            scrollView.addSubview(vc.view)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.addSubVCView()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidEndScrollingAnimation(scrollView)
        
        let newIndex = Int(scrollView.contentOffset.x/scrollView.width)
        titleView.titleAdjustScrollView(self.oldIndex, newIndex)
        
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.oldIndex = Int(scrollView.contentOffset.x / scrollView.width)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
