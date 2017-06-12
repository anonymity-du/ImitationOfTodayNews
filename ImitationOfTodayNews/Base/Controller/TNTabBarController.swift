//
//  TNTabBarController.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/5/25.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildViewControllers()
    }

    func addChildViewControllers() {
        
        let titleArr = ["首页","视频","关注","我的"]
        let imageNameArr = ["home_tabbar_22x22_","video_tabbar_22x22_","newcare_tabbar_22x22_","mine_tabbar_22x22_"]
        let selectImageNameArr = ["home_tabbar_press_22x22_","video_tabbar_press_22x22_","newcare_tabbar_press_22x22_","mine_tabbar_press_22x22_"]
        var childViewControllers = [UIViewController]()
        for index in 0..<titleArr.count {
            let vc = TNHomeViewController()
            let nav = TNNavigationController.init(rootViewController: vc)
            
            nav.title = titleArr[index]
            nav.tabBarItem.image = UIImage(named:imageNameArr[index])
            nav.tabBarItem.selectedImage = UIImage(named:selectImageNameArr[index])
            childViewControllers.append(nav)
        }
        setViewControllers(childViewControllers, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
