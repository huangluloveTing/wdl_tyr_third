//
//  WayBillDetailVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/1.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class WayBillDetailVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    public var wayBillInfo:WayBillInfoBean?
    
    private var pageInfo:WayBillInfoBean? = WayBillInfoBean()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pageInfo = self.wayBillInfo
        self.loadDetailInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func currentConfig() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: IPHONE_WIDTH, height: 60)))
        self.tableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0)
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor(hex: "DDDDDD")
        self.tableView.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
    }
    
    func registerCells() {
        self.registerCell(nibName: "\(WayBillDetailStatusCell.self)", for: self.tableView)
        self.registerCell(nibName: "\(WayBillDealInfoCell.self)", for: self.tableView)
        self.registerCell(nibName: "\(WayBillGoodsCell.self)", for: self.tableView)
        self.registerCell(nibName: "\(WayBillTransLocationCell.self)", for: self.tableView)
    }
}

extension WayBillDetailVC {
    
    // 根据 对应的状态 ， 展示不同的cells
    func tableViewCells(tableView:UITableView , indexPath:IndexPath) -> UITableViewCell {
        switch (self.wayBillInfo?.transportStatus)! {
        case WayBillTransportStatus.willToTransport:
            return self.willToTransportTableViewCell(tableView:tableView, indexPath:indexPath)
        case WayBillTransportStatus.transporting:
            return self.transportingCells(indexPath: indexPath, tableView: tableView)
        default:
            return self.willToTransportTableViewCell(tableView:tableView, indexPath:indexPath)
        }
    }
    
    // 待起运的状态下的 cells
    func willToTransportTableViewCell(tableView:UITableView ,indexPath:IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDetailStatusCell.self)") as! WayBillDetailStatusCell
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDealInfoCell.self)") as! WayBillDealInfoCell
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillGoodsCell.self)") as! WayBillGoodsCell
            cell.contentInfo(info: self.pageInfo)
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
    // 运输中的 cells
    func transportingCells(indexPath:IndexPath , tableView:UITableView) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDetailStatusCell.self)") as! WayBillDetailStatusCell
                return cell
            }
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillTransLocationCell.self)") as! WayBillTransLocationCell
                return cell
            }
            //TODO: 回执单
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDealInfoCell.self)") as! WayBillDealInfoCell
            return cell
        }
        // 成交信息
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDealInfoCell.self)") as! WayBillDealInfoCell
            return cell
        }
        // 货源信息
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillGoodsCell.self)") as! WayBillGoodsCell
            cell.contentInfo(info: self.pageInfo)
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
    func willToPickCells(indexPath:IndexPath , tableView:UITableView) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDetailStatusCell.self)") as! WayBillDetailStatusCell
                return cell
            }
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillTransLocationCell.self)") as! WayBillTransLocationCell
                return cell
            }
            //TODO: 回执单
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDealInfoCell.self)") as! WayBillDealInfoCell
            return cell
        }
        // 成交信息
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDealInfoCell.self)") as! WayBillDealInfoCell
            return cell
        }
        // 货源信息
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillGoodsCell.self)") as! WayBillGoodsCell
            cell.contentInfo(info: self.pageInfo)
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
}


//DataSource
extension WayBillDetailVC : UITableViewDelegate , UITableViewDataSource {
    
    //运单状态 1=待起运 2=运输中 3=待签收 4=已签收  5=被拒绝
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.pageInfo?.transportStatus == WayBillTransportStatus.willToTransport { // 待起运
            return 2
        }
        if self.pageInfo?.transportStatus == WayBillTransportStatus.transporting { // 运输中
            return 3
        }
        if self.pageInfo?.transportStatus == WayBillTransportStatus.done { // 已签收
            return 3
        }
        if self.pageInfo?.transportStatus == WayBillTransportStatus.willToPickup { // 待签收
            return 3
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.pageInfo?.transportStatus == WayBillTransportStatus.willToTransport { // 待起运
            if section == 0 {
                return 2
            }
            return 1
        }
        if self.pageInfo?.transportStatus == WayBillTransportStatus.transporting { // 运输中
            if section == 0 {
                return 3
            }
            return 1
        }
        if self.pageInfo?.transportStatus == WayBillTransportStatus.done { // 已签收
            if section == 0 {
                return 3
            }
            return 1
        }
        if self.pageInfo?.transportStatus == WayBillTransportStatus.willToPickup { // 待签收
            if section == 0 {
                return 3
            }
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableViewCells(tableView: tableView, indexPath: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

extension WayBillDetailVC {
    
    func loadDetailInfo() -> Void {
        self.showLoading()
        BaseApi.request(target: API.sinGletransaction(self.wayBillInfo?.id ?? ""), type: BaseResponseModel<String>.self)
            .subscribe(onNext: { (data) in
                self.showSuccess()
            }, onError: { (error) in
                self.showFail(fail: error.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
    }
}
