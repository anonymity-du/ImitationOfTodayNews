//
//  TNTopicDetailViewController.swift
//  ImitationOfTodayNews
//
//  Created by 杜奎 on 2017/6/29.
//  Copyright © 2017年 杜奎. All rights reserved.
//

import UIKit

class TNTopicDetailViewController: UIViewController {

    var topic : TNTopicModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        createUI()
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = TNColor(210, 63, 66, 1.0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    func createUI() {
        view.backgroundColor = TNGlobalGrayColor()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "new_more_titlebar_28x28_"), style: .plain, target: self, action: #selector(moreBtnClicked))
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationController?.navigationBar.barStyle = UIBarStyle.default
        
        navigationItem.titleView = searchBar
        searchBar.placeholder = topic?.source!
        
        view.addSubview(webView)
        let url = URL(string: (topic?.url!)!)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }
    
    fileprivate lazy var searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.width = SCREEN_WIDTH - 60
        searchBar.height = 30
        return searchBar
    }()
    
    fileprivate lazy var webView : UIWebView = {
        let webView = UIWebView(frame: CGRect(x: 0, y: 64, width: self.view.width, height: self.view.height - 64))
        webView.scalesPageToFit = true
        webView.dataDetectorTypes = .all
        return webView
    }()
    
    func moreBtnClicked() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
