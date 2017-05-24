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
        self.view.backgroundColor = UIColor.green
        var centerLabel = UILabel.init()
        centerLabel.text = "测试"
        centerLabel.textColor = UIColor.black
        centerLabel.sizeToFit()
        centerLabel.center = CGPoint(x:self.view.frame.size.width * 0.5,y:self.view.frame.size.height * 0.5)
        self.view.addSubview(centerLabel)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

