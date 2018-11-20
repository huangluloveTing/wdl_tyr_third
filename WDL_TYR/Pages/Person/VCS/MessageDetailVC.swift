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
        self.registerCell(nibName: "\(MessageCenterCell.self)", for: tableView)
        tableView.separatorStyle = .none
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
        self.queryBean.msgType = -1 // 消息类型 1=系统消息 2=报价消息 3=运单消息 ,
        self.queryBean.pageNum = 1 //当前页数 （注意这里有分页）
        self.showLoading()
        BaseApi.request(target: API.getDetailMessage(self.queryBean), type: BaseResponseModel<MessageQueryBean>.self)
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
extension MessageDetailVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MessageCenterCell.self)") as! MessageCenterCell
//        cell.showInfo(icon: icons[indexPath.row], title: titles[indexPath.row], content: nil)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
