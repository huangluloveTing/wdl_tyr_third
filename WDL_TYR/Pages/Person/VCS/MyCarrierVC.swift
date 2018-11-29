//
//  MyCarrierVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/20.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class MyCarrierVC: NormalBaseVC {
    
    private var searchText:String?
    
    private var carrierLists:[ZbnFollowCarrierVo]? = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configTableView()
        self.addRightBarbuttonItem(withTitle: "添加承运人")
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor(hex: "06C06F")], for: UIControlState.normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.loadMyCarrierLists(search: searchText ?? "")
    }
    
    override func zt_rightBarButtonAction(_ sender: UIBarButtonItem!) {
        let addCarrier = AddCarrierVC()
        addCarrier.showLeftBack = false
        self.push(vc: addCarrier, title: nil)
    }
    
    override func currentSearchContent(content: String) {
        searchText = content
        loadMyCarrierLists(search: content)
    }
}

extension MyCarrierVC {
    //MARK: - config tableView
    func configTableView() -> Void {
        tableView.delegate = self
        tableView.dataSource = self
        self.registerCell(nibName: "\(MyCarrierSearchCell.self)", for: tableView)
        self.registerCell(nibName: "\(MyCarrierInfoCell.self)", for: tableView)
        tableView.separatorStyle = .none
    }
    
    // 搜索回调
    func searchHandle(search:String) -> Void {
        self.loadMyCarrierLists(search: search)
    }
    
    // 刷新列表数据
    func reloadMyCarrierList() -> Void {
        tableView.reloadSections([1], with: .none)
    }
    
    //MARK: - 删除相应的承运人
    func deleteCarrier(index:Int) -> Void {
        let info = carrierLists![index]
        self.showLoading()
        BaseApi.request(target: API.deleteFollowCarrier(info.carrierId ?? ""), type: BaseResponseModel<String>.self)
            .retry(2)
            .subscribe(onNext: { [weak self](data) in
                self?.showSuccess(success: data.message, complete: nil)
                self?.loadMyCarrierLists(search: self?.searchText ?? "")
            }, onError: { (error) in
                self.showFail(fail: error.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
    }
}


extension MyCarrierVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(MyCarrierSearchCell.self)") as! MyCarrierSearchCell
            cell.searchClosure = {[weak self](search) in
               self?.searchHandle(search: search)
            }
            return cell
        }
        let info = carrierLists![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MyCarrierInfoCell.self)") as! MyCarrierInfoCell
        cell.showInfo(avatorImage: info.photoUrl,
                       title: info.carrierName,
                       phone: info.cellPhone,
                       rate: info.overallScore,
                       tomeNum: info.dealNum,
                       total: info.dealNum)
        cell.handleClosure = {[weak self] in
            self?.deleteCarrier(index: indexPath.row)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return carrierLists?.count ?? 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}


//MARK: - load data
extension MyCarrierVC {
    
    // 获取我的承运人数据
    func loadMyCarrierLists(search:String) -> Void {
        self.showLoading()

        BaseApi.request(target: API.selectFollowCarrier(search), type: BaseResponseModel<CarrierPageInfo<ZbnFollowCarrierVo>>.self)
            .retry(2)
            .subscribe(onNext: { [weak self](data) in
                self?.hiddenToast()
                self?.carrierLists = data.data?.list ?? []
                self?.reloadMyCarrierList()
                }, onError: { [weak self](error) in
                    self?.showFail(fail: error.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
        
        
        
    }
}
