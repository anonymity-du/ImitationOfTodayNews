//
//  TNHomeViewController.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/5/25.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit
import SVProgressHUD

class TNHomeViewController: UIViewController , UIScrollViewDelegate{

    var topicTitles = [TNHomeTopTitleModel]()
    var oldIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        // 设置导航栏属性
        navigationController?.navigationBar.barStyle = .black
        // 设置 titleView
        navigationItem.titleView = titleView
        // 添加滚动视图
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        tabBarController?.view.addSubview(popView)
        showRecommendCountTips()
        
        setTitleViewClosure()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = TNColor(210, 63, 66, 1.0)
    }
    
    func showPopView(_ filterWords : [TNFilterWord],_ btnCenter : CGPoint) {
        popView.filterWords = filterWords
        popView.btnCenter = btnCenter
        popView.show()
    }
    
    fileprivate func setTitleViewClosure() {
        titleView.addBtnClickedClosure = {[weak self] in
            let vc = TNChangeTopicViewController()
            vc.myTopics = self!.topicTitles
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        titleView.topicSelectedClosure = { [weak self] (titleLabel) in
            self!.scrollView.setContentOffset(CGPoint(x:CGFloat(titleLabel.tag) * self!.scrollView.width,y:0), animated: true)
        }
        titleView.titleViewDidInitClosure = { [weak self] (titleArr) in
            self!.topicTitles = titleArr
            _ = Reflect.save(obj: titleArr as AnyObject, name: "top_title", duration: 0)
            var colorNumber : CGFloat = 10;
            for topTitle in titleArr {
                let topicVC = TNTopicViewController()
                topicVC.homeVC = self
                topicVC.titleModel = topTitle
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
        
        NetworkManager.shareManager.fetchRecommendArticleNumber({ [weak self](count) in
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
        }) { (error) in
            SVProgressHUD.showError(withStatus: "加载失败...")
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
    
    fileprivate lazy var popView : TNPopView = {
        let pop = TNPopView(frame: self.view.bounds)
        pop.alpha = 0
        return pop
    }()
    
    fileprivate func addSubVCView() {
        let index = Int(scrollView.contentOffset.x/scrollView.width)
        let vc = self.childViewControllers[index] as! TNTopicViewController
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
