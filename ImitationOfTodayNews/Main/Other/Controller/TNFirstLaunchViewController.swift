//
//  TNFirstLaunchViewController.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/5/25.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNFirstLaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func phoneBtnClicked(_ sender: UIButton) {
        print("phone btn clicked")
    }
    
    @IBAction func qqBtnClicked(_ sender: UIButton) {
        print("qq btn clicked")
    }
    
    @IBAction func EnterBtnClicked(_ sender: UIButton) {
        print("enter btn clicked")
    }
    
    @IBAction func sinaBtnClicked(_ sender: UIButton) {
        print("sina btn clicked")
    }
    
    @IBAction func weChatBtnClicked(_ sender: UIButton) {
        print("weChat btn clicked")
    }
}
