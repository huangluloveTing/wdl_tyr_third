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
    @IBOutlet weak var tableView: UITableView!
    
    private let titles = ["报价信息","运单信息","系统信息"]
    private let icons = [UIImage.init(named: "message_offer")!,UIImage.init(named: "message_yd")!,UIImage.init(named: "message_alert")!]

    override func viewDidLoad() {
        super.viewDidLoad()
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
    //数据请求
    func loadInfoRequest(){
        //配置参数
        self.queryBean.startTime = ""
        self.queryBean.endTime = ""
        self.queryBean.msgTo = "" //（当前用户的id号）
        self.queryBean.msgType = -1 // 消息类型 1=系统消息 2=报价消息 3=运单消息 ,
        self.queryBean.pageNum = 1 //当前页数 （主页没有分页，详情页有）

        BaseApi.request(target: API.getMainMessage(self.queryBean), type: BaseResponseModel<MessageQueryBean>.self)
            .subscribe(onNext: { [weak self](data) in
                self?.showSuccess(success: nil)
//                self?.configNetDataToUI(lists: data.data?.list ?? [])
            
                }, onError: {[weak self] (error) in
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
extension MessageCenterVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MessageCenterCell.self)") as! MessageCenterCell
        cell.showInfo(icon: icons[indexPath.row], title: titles[indexPath.row], content: nil)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: - Handles
extension MessageCenterVC {
    
    // 去报价信息
    func toOfferMessages() -> Void {
        
    }
    
    // 去运单信息
    func wayBillsMessages() -> Void {
        
    }
    
    // 去系统信息
    func systermMessages() -> Void {
        
    }
}
