//
//  TNConfig.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/5/25.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

let IID: String = "5034850950"
let device_id: String = "6096495334"
let BASE_URL = "http://lf.snssdk.com/"

//字体

let ContentFont11 = UIFont.systemFont(ofSize: 11)
let ContentFont12 = UIFont.systemFont(ofSize: 12)
let ContentFont13 = UIFont.systemFont(ofSize: 13)
let ContentFont14 = UIFont.systemFont(ofSize: 14)
let ContentFont15 = UIFont.systemFont(ofSize: 15)
let ContentFont16 = UIFont.systemFont(ofSize: 16)
let ContentFont17 = UIFont.systemFont(ofSize: 17)
let ContentFont18 = UIFont.systemFont(ofSize: 18)


//常量
let NavigationTitleHeight : CGFloat = 44.0
let TabBarHeight = 40.0
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let kHomeMargin: CGFloat = 15.0
let kMargin: CGFloat = 10.0

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

