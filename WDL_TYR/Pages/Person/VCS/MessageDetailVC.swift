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
    private var hallLists:[MessageQueryBean] = []
    //用户信息
    private var zbnConsignor:ZbnConsignor?
    //当前消息类型
    public var currentMsgType:Int?
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //获取用户信息
        self.zbnConsignor = WDLCoreManager.shared().userInfo
        configTableView()
        loadInfoRequest()
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

//MARK: - loadData
extension MessageDetailVC {
    //消息详情页数据请求
    func loadInfoRequest(){
        //配置参数
         let id = WDLCoreManager.shared().userInfo?.id ?? ""
        self.queryBean.startTime = ""
        self.queryBean.endTime = ""
        self.queryBean.msgTo = id //（当前用户的id号）
        self.queryBean.msgType = self.currentMsgType // 消息类型 1=系统消息 2=报价消息 3=运单消息 ,
        self.queryBean.pageNum = 1 //当前页数 （注意这里有分页）
        self.showLoading()
        BaseApi.request(target: API.getDetailMessage(self.queryBean), type: BaseResponseModel<PageInfo<MessageQueryBean>>.self)
            .retry(2)
            .subscribe(onNext: { [weak self](data) in
                self?.showSuccess(success: nil)
                self?.configNetDataToUI(lists: data.data?.list ?? [])
                },
                       onError: {[weak self] (error) in
                        self?.showFail(fail: error.localizedDescription)
            })
            .disposed(by: dispose)
        
    }
    
    
    // 根据获取数据,组装列表
    func configNetDataToUI(lists:[MessageQueryBean]) -> Void {
        self.hallLists = lists
        self.tableView.reloadData()
    }
    
    
}



//MARK: - UITableViewDelegate , UITableViewDataSource
extension MessageDetailVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MessageDetailCell.self)") as! MessageDetailCell
        cell.btnHeightConstant.constant = 30 //默认按钮高度30
        let info = self.hallLists[indexPath.row]
        var title:String? = ""
        var btnTitle:String? = ""
        if info.msgType == 1 { //系统消息
            title = "系统消息"
            btnTitle = ""
            cell.rightBtn.isHidden = true
            cell.btnHeightConstant.constant = 0
        }
        if info.msgType == 2 { //报价消息
            title = "报价消息"
            btnTitle = "查看货源"
            cell.rightBtn.isHidden = false
        }
        if info.msgType == 3 { // 运单信息
            title = "运单信息"
            btnTitle = "查看运单"
            cell.rightBtn.isHidden = false
        }
       
        cell.showDetalMessageInfo(title: title ?? "", content: info.msgInfo, time: info.createTime, buttonTitle: btnTitle ?? "",hallId: info.hallNo ?? "")
        
        //cell按钮点击跳转事件
        
        cell.buttonClosure = { [weak self] (sender, hallId) in
            
            if sender.titleLabel?.text == "查看货源" {
                //跳转货源详情
                var supplyDetail = GoodsSupplyListItem()
                supplyDetail.id = hallId
                
                let vc = GoodsSupplyDetailVC()
                vc.supplyDetail = supplyDetail
              
                self?.push(vc: vc, title: "货源详情")
            }
            else if sender.titleLabel?.text == "查看运单" {
                //跳转运单详情
                var wayBillInfo = WayBillInfoBean()
                wayBillInfo.id = hallId
                let vc = WayBillDetailVC()
                vc.wayBillInfo = wayBillInfo
                self?.push(vc: vc, title: "运单详情")
            }
            
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hallLists.count
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
}
