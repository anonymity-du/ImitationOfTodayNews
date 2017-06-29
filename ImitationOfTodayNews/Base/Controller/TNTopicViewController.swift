//
//  TNTopicViewController.swift
//  ImitationOfTodayNews
//
//  Created by dukui on 2017/6/16.
//  Copyright © 2017年 dukui. All rights reserved.
//

import UIKit
import MJRefresh
import SVProgressHUD

let NoImageCellIdentifier = "NoImageCellIdentifier"
let ThreeImageCellIdentifier = "ThreeImageCellIdentifier"
let LargeImageCellIdentifier = "LargeImageCellIdentifier"
let RightImageCellIdentifier = "RightImageCellIdentifier"

class TNTopicViewController: ListViewController,UITableViewDelegate,UITableViewDataSource,GenericCellDelegate {
    
    weak var homeVC : TNHomeViewController?
    var didLoad : Bool = false
    var titleModel : TNHomeTopTitleModel?
    var refreshTime : TimeInterval = 0
    var dataArray = [TNTopicModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !didLoad {
            didLoad = true
            self.tableView.frame = self.view.bounds
            self.tableView.mj_header.beginRefreshing()
        }
    }
    
    override func refreshAction() {
        self.refreshTime = 0
        NetworkManager.shareManager.fetchHomeCategoryNews((titleModel?.category)!, self.refreshTime, { [weak self] (topics) in
            self?.refreshTime = Date().timeIntervalSince1970
            self?.endRefresh()
//            print(topics)
            self?.calculateDistance(topics)
            self?.dataArray.removeAll()
            self?.dataArray.append(contentsOf: topics)
            self?.tableView.reloadData()
        }) { [weak self](error) in
            self?.endRefresh()
            SVProgressHUD.showError(withStatus: "加载失败...")
        }
    }
    
    override func loadMoreAction() {
        NetworkManager.shareManager.fetchHomeCategoryNews((titleModel?.category)!, self.refreshTime, {[weak self] (topics) in
            self?.refreshTime = Date().timeIntervalSince1970
            self?.endRefresh()
//            print(topics)
            self?.calculateDistance(topics)
            self?.dataArray.append(contentsOf: topics)
            self?.tableView.reloadData()
        }) { [weak self](error) in
            self?.endRefresh()
            SVProgressHUD.showError(withStatus: "加载失败...")
        }
    }
    
    fileprivate func calculateDistance(_ topics:[TNTopicModel]) {
        for itemTopic in topics {
            var imageW : CGFloat = 0
            var imageH : CGFloat = 0
            var titleW : CGFloat = 0
            var titleH : CGFloat = 0
            var cellHeight : CGFloat = 0
            
            if itemTopic.image_list.count == 0 {
                // 再判断 middle_image 是否为空
                if itemTopic.middle_image?.height != nil {
                    // 大图、视频图片或广告
                    // 如果 large_image_list 或 video_detail_info 不为空，则显示一张大图 (SCREENW -30)×170，文字在上边
                    // 再判断 video_detail_info 是否为空
                    if itemTopic.video_detail_info?.video_id != nil || itemTopic.large_image_list.count > 0 {
                        imageW = SCREEN_WIDTH - CGFloat(30)
                        imageH = 170
                        titleW = SCREEN_WIDTH - 30
                        titleH = NSString.boundingRectWithString(itemTopic.title!, size: CGSize(width: titleW, height: CGFloat(MAXFLOAT)), fontSize: 17)
                        // 中间有一张大图（包括视频和广告的图片），cell 的高度 = 底部间距 + 标题的高度 + 中间间距 + 图片高度 + 中间间距 + 用户头像的高度 + 底部间距
                        cellHeight = 2 * kHomeMargin + titleH + imageH + 2 * kMargin + 16
                    } else {
                        // 如果 middle_image 不为空，则在 cell 显示一张图片 70 × 108，文字在左边，图片在右边
                        // 说明是右边图
                        imageW = 108
                        // 图片在右边的情况和有三张图片的情况，为了计算简单，图片的高度设置为相等
                        imageH = 70
                        // 文字宽度 SCREENW - 108 - 30 - 20
                        titleW = SCREEN_WIDTH - 158
                        titleH = NSString.boundingRectWithString(itemTopic.title!, size: CGSize(width: titleW, height: CGFloat(MAXFLOAT)), fontSize: 17)
                        // 比较标题和图片的高度哪个大，那么 cell 的高度就根据大的计算
                        // 右边有一张图片，cell 的高度 = 底部间距 + 标题的高度 + 中间的间距 + 用户头像的高度 + 底部间距
                        cellHeight = (titleH + 16 + kMargin >= imageH) ? (2 * kHomeMargin + titleH + kMargin + 16):(2 * kHomeMargin + imageH)
                    }
                } else { // 没有图片,也不是视频
                    titleW = SCREEN_WIDTH - 30
                    titleH = NSString.boundingRectWithString(itemTopic.title!, size: CGSize(width: titleW, height: CGFloat(MAXFLOAT)), fontSize: 17)
                    // 没有图片，cell 的高度 = 底部间距 + 标题的高度 + 中间的间距 + 用户头像的高度 + 底部间距
                    cellHeight = 2 * kHomeMargin + titleH + kMargin + 16
                }
            } else {
                // 如果 image_list 不为空，则显示 3 张图片 ((SCREENW -30 -12) / 3)×70，文字在上边
                // 循环遍历 image_list
                imageW = (SCREEN_WIDTH - CGFloat(42)) / 3
                imageH = 70
                // 文字的宽度 SCREENW-30
                titleW = SCREEN_WIDTH - 30
                titleH = NSString.boundingRectWithString(itemTopic.title!, size: CGSize(width: titleW, height: CGFloat(MAXFLOAT)), fontSize: 17)
                cellHeight = 2 * kHomeMargin + titleH + imageH + 2 * kMargin + 16
            }
            itemTopic.imageW = imageW
            itemTopic.imageH = imageH
            itemTopic.titleW = titleW
            itemTopic.titleH = titleH
            itemTopic.cellHeight = cellHeight
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = self.dataArray[indexPath.row]
        if model.image_list.count > 0 {
            var cell = tableView.dequeueReusableCell(withIdentifier: ThreeImageCellIdentifier)
            if cell == nil{
                cell = TNHomeThreeImageCell(style: UITableViewCellStyle.default, reuseIdentifier: ThreeImageCellIdentifier)
            }
            (cell as? TNHomeThreeImageCell)?.delegate = self
            (cell as? TNHomeThreeImageCell)?.model = model
            return cell!
            
        }else {
            if model.middle_image?.height != nil {
                if model.video_detail_info?.video_id != nil || model.large_image_list.count != 0 {
                    var cell = tableView.dequeueReusableCell(withIdentifier: LargeImageCellIdentifier)
                    if cell == nil {
                        cell = TNHomeLargeImageCell(style: UITableViewCellStyle.default, reuseIdentifier: LargeImageCellIdentifier)
                    }
                    (cell as? TNHomeLargeImageCell)?.delegate = self
                    (cell as? TNHomeLargeImageCell)?.model = model
                    return cell!
                }else {
                    var cell = tableView.dequeueReusableCell(withIdentifier: RightImageCellIdentifier)
                    if cell == nil{
                        cell = TNHomeRightImageCell(style: UITableViewCellStyle.default, reuseIdentifier: RightImageCellIdentifier)
                    }
                    (cell as? TNHomeRightImageCell)?.delegate = self
                    (cell as? TNHomeRightImageCell)?.model = model
                    return cell!
                }
            }else {
                var cell = tableView.dequeueReusableCell(withIdentifier: NoImageCellIdentifier)
                if cell == nil{
                    cell = TNHomeNoImageCell(style: UITableViewCellStyle.default, reuseIdentifier: NoImageCellIdentifier)
                }
                (cell as? TNHomeNoImageCell)?.delegate = self
                (cell as? TNHomeNoImageCell)?.model = self.dataArray[indexPath.row]
                return cell!
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let topicModel = self.dataArray[indexPath.row]
        return topicModel.cellHeight
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = TNTopicDetailViewController()
        vc.topic = self.dataArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func closeBtnClicked(_ topicModel : TNTopicModel,_ cell : TNHomeGenericCell,_ closeBtn : UIButton) {
        var btnCenter : CGPoint = self.view.convert(closeBtn.center, from: cell.contentView)
        btnCenter.y = btnCenter.y + 64
        self.homeVC?.showPopView(topicModel.filter_words,btnCenter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
