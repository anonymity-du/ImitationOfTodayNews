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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        // 设置导航栏属性
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = TNColor(210, 63, 66, 1.0)
        // 设置 titleView
        navigationItem.titleView = titleView
        // 添加滚动视图
        view.addSubview(scrollView)
        
        // Do any additional setup after loading the view.
    }

    fileprivate lazy var titleView : TNHomeTitleView = {
        let titleView = TNHomeTitleView(frame:CGRect.init(x: 0, y: 0, width: self.view.width, height: NavigationTitleHeight))
        titleView.addBtnClickedClosure = {
            
        }
        titleView.topicSelectedClosure = { [weak self] (titleLabel) in
            
        }
        titleView.titleViewDidInitClosure = { [weak self] (titleArr) in
            self!.topicTitles = titleArr
            _ = Reflect.save(obj: titleArr as AnyObject, name: "top_title", duration: 0)
            for topTitle in titleArr {
                let topicVC = UIViewController()
                topicVC.title = topTitle.name
                topicVC.view.backgroundColor = UIColor.orange
                self!.addChildViewController(topicVC)
            }
            self!.addSubVCView()
            self!.scrollView.contentSize = CGSize.init(width: self!.view.width * CGFloat(titleArr.count), height: self!.scrollView.height)
        }
        return titleView
    }()
    
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = CGRect(x: 0, y: 64, width: self.view.width, height: self.view.height - 64 - 44)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        scrollView.backgroundColor = UIColor.purple
        return scrollView;
    }()
    
    fileprivate func addSubVCView() {
        let index = Int(scrollView.contentOffset.x/scrollView.width)
        let vc = self.childViewControllers[index]
        vc.view.x = scrollView.contentOffset.x
        vc.view.y = 0
        vc.view.height = scrollView.height
        vc.view.width = scrollView.width
        if !scrollView.subviews.contains(vc.view) {
            scrollView.addSubview(vc.view)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
