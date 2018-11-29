//
//  MessageCenterVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/3.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class MessageCenterVC: NormalBaseVC {
    //参数
    private var queryBean : MessageQueryBean = MessageQueryBean()
    //数组
    private var hallLists:[MessageQueryBean] = []
    //用户信息
    private var zbnConsignor:ZbnConsignor?
    
    private var pageSize:Int = 20
  
    @IBOutlet weak var tableView: UITableView!
    
    private let titles = ["报价信息","运单信息","系统信息"]
    private let icons = [UIImage.init(named: "message_offer")!,
                         UIImage.init(named: "message_yd")!,
                         UIImage.init(named: "message_alert")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        //获取用户信息
        self.zbnConsignor = WDLCoreManager.shared().userInfo
        configTableView()
        
    }
}

//MARK: - config
extension MessageCenterVC {
    func configTableView() -> Void {
        tableView.delegate = self
        tableView.dataSource = self
        self.registerCell(nibName: "\(MessageCenterCell.self)", for: tableView)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.pullRefresh()
        tableView.upRefresh()
        tableView.estimatedRowHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.refreshState.asObservable()
            .distinctUntilChanged()
            .throttle(1, scheduler: MainScheduler.instance)
            .filter({ (state) -> Bool in
                return state != .EndRefresh
            })
            .subscribe(onNext: { [weak self](state) in
                if state == .LoadMore {
                    self?.refreshMessage()
                }
                if state == .Refresh {
                    self?.loadMoreMessage()
                }
            })
            .disposed(by: dispose)
        tableView.beginRefresh()
    }
    
    func refreshMessage() -> Void {
        self.pageSize = 20
        tableView.resetFooter()
        tableView.removeCacheHeights()
        loadInfoRequest(pageSize: self.pageSize)
    }
    
    func loadMoreMessage() -> Void {
        self.pageSize += 20
        loadInfoRequest(pageSize: self.pageSize)
    }
}

//MARK: - loadData
extension MessageCenterVC {
    //消息中心主页数据请求
    func loadInfoRequest(pageSize:Int){
        //配置参数
        self.showLoading()
        self.queryBean.pageSize = pageSize
        BaseApi.request(target: API.getMainMessage(self.queryBean), type: BaseResponseModel<PageInfo<MessageQueryBean>>.self)
            .retry(2)
            .subscribe(onNext: { [weak self](data) in
                self?.tableView.endRefresh()
                self?.showSuccess(success: nil)
                self?.configNetDataToUI(lists: data.data?.list ?? [])
                if (data.data?.list?.count ?? 0) >= (data.data?.total ?? 0) {
                    self?.tableView.noMore()
                }
            },onError: {[weak self] (error) in
                self?.showFail(fail: error.localizedDescription)
            })
            .disposed(by: dispose)
    }
    
    // 根据获取数据,组装列表
    func configNetDataToUI(lists:[MessageQueryBean]) -> Void {
        // msgType (integer): 消息类型 1=系统消息 2=报价消息 3=运单消息 ,
        self.hallLists = lists
        self.tableView.reloadData()
    }
 
    
}



//MARK: - UITableViewDelegate , UITableViewDataSource
extension MessageCenterVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MessageCenterCell.self)") as! MessageCenterCell
        let info = self.hallLists[indexPath.row]
        var icon:UIImage? = nil
        var title:String? = ""
        if info.msgType == 1 { //系统消息
            icon = icons[2]
            title = "系统消息"
        }
        if info.msgType == 2 { //报价消息
            icon = icons[0]
            title = "报价消息"
        }
        if info.msgType == 3 { // 运单信息
            icon = icons[1]
            title = "运单信息"
        }
        cell.showInfo(icon: icon ?? icons[0], title: title ?? "", content: info.msgInfo)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hallLists.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        let info = self.hallLists[indexPath.row]
        if info.msgType == 1 { //系统消息
           self.systermMessages()
        }
        if info.msgType == 2 { //报价消息
           self.toOfferMessages()
        }
        if info.msgType == 3 { // 运单信息
           self.wayBillsMessages()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.heightForRow(at: indexPath)
    }
}

//MARK: - Handles
extension MessageCenterVC {
    
    
    // 去报价信息
    func toOfferMessages() -> Void {
        let vc = MessageDetailVC()
        vc.currentMsgType = 2
        self.push(vc: vc, animated: true, title: "消息详情")
    }
    
    // 去运单信息
    func wayBillsMessages() -> Void {
        let vc = MessageDetailVC()
        vc.currentMsgType = 3
        self.push(vc: vc, animated: true, title: "消息详情")
    }
    
    // 去系统信息
    func systermMessages() -> Void {
        let vc = MessageDetailVC()
        vc.currentMsgType = 1
        self.push(vc: vc, animated: true, title: "消息详情")
    }
}
