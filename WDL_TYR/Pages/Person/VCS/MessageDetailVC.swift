//
//  MessageDetailVC.swift
//  WDL_TYR
//
//  Created by Apple on 2018/11/20.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class MessageDetailVC: NormalBaseVC {
    //参数
    private var queryBean : MessageQueryBean = MessageQueryBean()
    //数组
//    private var hallLists:[MessageQueryBean] = []
    //用户信息
    private var zbnConsignor:ZbnConsignor?
    //当前消息类型
    public var currentMsgType:Int?
    //当前消息的信息
    public var currentInfo:MessageQueryBean?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //获取用户信息
        self.zbnConsignor = WDLCoreManager.shared().userInfo
        configTableView()
    }
}

//MARK: - config
extension MessageDetailVC {
    func configTableView() -> Void {
        tableView.delegate = self
        tableView.dataSource = self
        self.registerCell(nibName: "\(MessageDetailCell.self)", for: tableView)
        tableView.tableFooterView = UIView()
    }
}



//MARK: - UITableViewDelegate , UITableViewDataSource
extension MessageDetailVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MessageDetailCell.self)") as! MessageDetailCell
        cell.btnHeightConstant.constant = 30 //默认按钮高度30
        let info = self.currentInfo
        var title:String? = ""
        var btnTitle:String? = ""
        if info?.msgType == 1 { //系统消息
            title = "系统消息"
            btnTitle = ""
            cell.rightBtn.isHidden = true
            cell.btnHeightConstant.constant = 0
        }
        if info?.msgType == 2 { //报价消息
            title = "报价消息"
            btnTitle = "查看货源"
            cell.rightBtn.isHidden = false
        }
        if info?.msgType == 3 { // 运单信息
            title = "运单信息"
            btnTitle = "查看运单"
            cell.rightBtn.isHidden = false
        }
       
        cell.showDetalMessageInfo(title: title ?? "", content: info?.msgInfo, time: info?.createTime, buttonTitle: btnTitle ?? "",hallId: info?.hallNo ?? "")
        
        //cell按钮点击跳转事件
        
        cell.buttonClosure = { [weak self] (sender, hallId) in
            
            if sender.titleLabel?.text == "查看货源" {
                //跳转货源详情
                var supplyDetail = GoodsSupplyListItem()
                supplyDetail.id = hallId
                self?.toGoodsSupplyDetail(item: supplyDetail)
            }
            else if sender.titleLabel?.text == "查看运单" {
                //跳转运单详情
                var wayBillInfo = WayBillInfoBean()
                wayBillInfo.id = hallId
                self?.toWayBillDetail(wayBillInfo: wayBillInfo)
            }
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
}
