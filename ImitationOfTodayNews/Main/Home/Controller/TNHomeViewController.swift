//
//  TNHomeViewController.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/5/25.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        automaticallyAdjustsScrollViewInsets = false
        // 设置导航栏属性
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = TNColor(210, 63, 66, 1.0)
        // 设置 titleView
        navigationItem.titleView = TNHomeTitleView(frame:CGRect.init(x: 0, y: 0, width: self.view.width, height: NavigationTitleHeight))
        // 添加滚动视图

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
