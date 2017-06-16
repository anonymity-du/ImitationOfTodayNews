//
//  TNTopicViewController.swift
//  ImitationOfTodayNews
//
//  Created by dukui on 2017/6/16.
//  Copyright © 2017年 dukui. All rights reserved.
//

import UIKit
import MJRefresh

class TNTopicViewController: ListViewController,UITableViewDelegate,UITableViewDataSource {
    
    var didLoad : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.refreshAction()
    }
    
    override func refreshAction() {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
