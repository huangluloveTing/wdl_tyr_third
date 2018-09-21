//
//  WayBillCommentVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/19.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class WayBillCommentVC: BaseVC  {

    @IBOutlet weak var tableView: UITableView!
    private var pageInfo:WayBillInfoBean?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func registerCells() -> Void {
        self.tableView.register(UINib.init(nibName: "\(WayBillCommentCell.self)", bundle: nil), forCellReuseIdentifier: "\(WayBillCommentCell.self)")
        self.tableView.register(UINib.init(nibName: "\(WayBillToCommentCell.self)", bundle: nil), forCellReuseIdentifier: "\(WayBillToCommentCell.self)")
    }
}

extension WayBillCommentVC {
    
    // 显示成交信息的 info
    func showInfoForDealCell(cell:WayBillDealInfoCell) -> Void {
        let unit = self.pageInfo?.dealUnitPrice
        let amount = self.pageInfo?.dealTotalPrice
        let cyName = self.pageInfo?.carrierName
        let driver = self.pageInfo?.dirverName
        let truckInfo = Util.concatSeperateStr(seperete: " | ", strs: self.pageInfo?.vehicleLength , self.pageInfo?.vehicleWidth , self.pageInfo?.vehicleType , self.pageInfo?.vehicleNo)
        let dealTime = self.pageInfo?.dealTime
        
        cell.showDealInfo(unit: unit,
                          amount: amount,
                          cyName: cyName,
                          driver: driver,
                          truckInfo: truckInfo,
                          dealTime: dealTime)
    }
}

extension WayBillCommentVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillCommentCell.self)") as! WayBillCommentCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillToCommentCell.self)") as! WayBillToCommentCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}
