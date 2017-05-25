//
//  ViewController.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/5/24.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = TNGlobalRedColor()
        let centerLabel = UILabel.init()
        centerLabel.text = "测试换个标题"
        centerLabel.textColor = UIColor.hexColor("65abbb", 1.0)
        centerLabel.sizeToFit()
        centerLabel.center = CGPoint(x:self.view.width * 0.5,y:self.view.height * 0.5)
        self.view.addSubview(centerLabel)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

