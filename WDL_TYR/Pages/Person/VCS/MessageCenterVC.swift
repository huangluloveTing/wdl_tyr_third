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
        loadInfoRequest()
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
    }
}

//MARK: - loadData
extension MessageCenterVC {
    //消息中心主页数据请求
    func loadInfoRequest(){
        //配置参数
//         let id = WDLCoreManager.shared().userInfo?.id ?? ""
//        self.queryBean.startTime = ""
//        self.queryBean.endTime = ""
//        self.queryBean.msgTo = id //（当前用户的id号）
//        self.queryBean.msgType = -1 // 消息类型 1=系统消息 2=报价消息 3=运单消息 ,
//        self.queryBean.pageNum = 1 //当前页数 （主页没有分页，详情页有）
        self.showLoading()
        
        BaseApi.request(target: API.getMainMessage(self.queryBean), type: BaseResponseModel<PageInfo<MessageQueryBean>>.self)
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
        //test
        self.toOfferMessages(index: indexPath.row)
        
    }
}

//MARK: - Handles
extension MessageCenterVC {
    
    // 去报价信息
    func toOfferMessages(index:Int) -> Void {
        let vc = MessageDetailVC()
        self.push(vc: vc, animated: true, title: "消息详情")
    }
    
    // 去运单信息
    func wayBillsMessages() -> Void {
        
    }
    
    // 去系统信息
    func systermMessages() -> Void {
        
    }
}
