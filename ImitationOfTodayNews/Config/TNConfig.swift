//
//  TNConfig.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/5/25.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

//初始化设置

func CustomizeAppearance() {
    let navBar = UINavigationBar.appearance()
    navBar.barTintColor = UIColor.white
    navBar.tintColor = UIColor.hexColor("000000", 0.7)
    navBar.titleTextAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 17.0)]
    
    let tabBar = UITabBar.appearance()
    tabBar.tintColor = TNColor(111, 111, 111, 1.0)
}

//颜色处理
func TNColor(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor {
    return UIColor.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
}

func TNGlobalGrayColor() -> UIColor {
    return TNColor(245, 245, 245 ,1.0)
}

func TNGlobalRedColor() -> UIColor {
    return TNColor(245, 80, 83, 1.0)
}

