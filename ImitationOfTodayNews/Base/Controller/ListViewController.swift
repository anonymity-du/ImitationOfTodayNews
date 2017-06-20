//
//  ListViewController.swift
//  ImitationOfTodayNews
//
//  Created by dukui on 2017/6/16.
//  Copyright © 2017年 dukui. All rights reserved.
//

import UIKit
import MJRefresh

class ListViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        tableView.mj_header = refreshNormalHeader
        tableView.mj_footer = refreshNormalFooter
        // Do any additional setup after loading the view.
    }
    
    lazy var tableViewStyle : UITableViewStyle = {
        let style = UITableViewStyle.plain
        return style
    }()
    
    lazy var tableView : GenericTableView = {
        let tableView = GenericTableView(frame: self.view.bounds, style: self.tableViewStyle)
        tableView.backgroundColor = UIColor.white
        tableView.autoresizingMask = [UIViewAutoresizing.flexibleTopMargin, UIViewAutoresizing.flexibleLeftMargin,UIViewAutoresizing.flexibleRightMargin ,UIViewAutoresizing.flexibleBottomMargin]
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    fileprivate lazy var refreshNormalHeader:MJRefreshNormalHeader = {
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(refreshAction))
        return header!
    }()
    
    fileprivate lazy var refreshNormalFooter:MJRefreshBackNormalFooter = {
        let footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreAction))
        return footer!
    }()
    
    func refreshAction() {
        self.tableView.mj_header.beginRefreshing()
    }
    
    func loadMoreAction() {
        self.tableView.mj_footer.beginRefreshing()
    }
    
    func endRefresh() {
        self.tableView.mj_header.endRefreshing()
        self.tableView.mj_footer.endRefreshing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
