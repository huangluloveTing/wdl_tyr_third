//
//  ChangeCarrierVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/29.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChangeCarrierVC: NormalBaseVC {
    
    private var searchText:String?
    
    public var transportNo:String?
    
    private var carrierLists:[ZbnFollowCarrierVo]? = []
    
    private var carrierQuery:SelectCarrierQueryModel = SelectCarrierQueryModel()

    @IBOutlet weak var searchCarrierBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        tableView.beginRefresh()
    }
    
    func configTableView() -> Void {
        tableView.delegate = self
        tableView.initEstmatedHeights()
        tableView.dataSource = self
        self.registerCell(nibName: "\(SearchCarrierCell.self)", for: tableView)
        searchCarrierBar.delegate = self
        tableView.pullRefresh()
        tableView.upRefresh()
        tableView.refreshAndLoadState().asObservable()
            .subscribe(onNext: {[weak self] (state) in
                if state == .LoadMore {
                    self?.carrierQuery.pageSize += 20
                }
                if state == .Refresh {
                    self?.tableView.removeCacheHeights()
                    self?.carrierQuery.pageSize = 20
                }
                self?.loadMyCarrierLists()
            })
            .disposed(by: dispose)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.bottomHandles(titles: ["取消","确定"], targetView: self.view, enable: true) { (index) in
            if index == 0 {
                self.cancelHandle()
            }else {
                self.sureHandle()
            }
        }
        self.tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: IPHONE_WIDTH, height: 60)))
    }

    func sureHandle() -> Void {
        self.updateCarrier()
    }
    
    func cancelHandle() -> Void {
        self.pop()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.carrierQuery.searchWord = searchText
    }
    override func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.tableView.beginRefresh()
    }
}


extension ChangeCarrierVC {
    // 获取我的承运人数据
    func loadMyCarrierLists() -> Void {
        self.showLoading()
        BaseApi.request(target: API.selectFollowCarrier(self.carrierQuery), type: BaseResponseModel<CarrierPageInfo<ZbnFollowCarrierVo>>.self)
            .retry(5)
            .subscribe(onNext: { [weak self](data) in
                self?.hiddenToast()
                self?.tableView.endRefresh()
                self?.carrierLists = data.data?.list ?? []
                self?.tableView.tableResultHandle(currentListCount: data.data?.list?.count, total: data.data?.total)
                self?.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
                self?.tableView.reloadData()
                }, onError: { [weak self](error) in
                    self?.tableView.endRefresh()
                    self?.showFail(fail: error.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
    }
    
    // 修改承运人
    func updateCarrier() -> Void {
        let indexPath = tableView.indexPathForSelectedRow
        guard let selectedIndexPath = indexPath else {
            self.showWarn(warn: "请选择承运人", complete: nil)
            return
        }
        let info = self.carrierLists![selectedIndexPath.row]
        var carrier = UpdateCarrierVo()
        carrier.carrierId = info.carrierId
        carrier.carrierName = info.carrierName
        carrier.carrierPhone = info.cellPhone
        carrier.transportNo = self.transportNo
        self.showLoading()
        BaseApi.request(target: API.updateCarrier(carrier), type: BaseResponseModel<String>.self)
            .retry(5)
            .subscribe(onNext: { [weak self](data) in
                self?.showSuccess(success: data.message, complete: {
                    self?.pop()
                })
            }, onError: { [weak self](error) in
                self?.showFail(fail: error.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
    }
}

extension ChangeCarrierVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let info = self.carrierLists![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchCarrierCell.self)") as! SearchCarrierCell
        cell.showInfo(name: info.carrierName, phone: info.cellPhone)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.carrierLists?.count ?? 0
    }
    
}

extension ChangeCarrierVC {
    
}
