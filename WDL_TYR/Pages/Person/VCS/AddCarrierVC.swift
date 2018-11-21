
//
//  AddCarrierVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/21.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class AddCarrierVC: NormalBaseVC {
    
    private var carrierLists:[ZbnFollowCarrierVo]? = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        self.fd_interactivePopDisabled = true
        self.addRightBarbuttonItem(withTitle: "取消")
        self.addLeftBarbuttonItem(withTitle: "")
        self.addNaviHeader(placeholder: "请输入承运人电话号码")
    }
    
    override func zt_rightBarButtonAction(_ sender: UIBarButtonItem!) {
        self.pop()
    }
    
    override func currentSearchContent(content: String) {
        self.searchCarrierForAdd(search: content)
    }
}

//MARK: - config tableView
extension AddCarrierVC {
    func configTableView() -> Void {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        self.registerCell(nibName: "\(MyCarrierInfoCell.self)", for: tableView)
    }
}

//MARK: - UITableViewDelegate , UITableViewDataSource
extension AddCarrierVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MyCarrierInfoCell.self)") as! MyCarrierInfoCell
        let info = carrierLists![indexPath.row]
        cell.showInfo(avatorImage: info.photoUrl,
                      title: info.carrierName,
                      phone: info.cellPhone,
                      rate: info.overallScore,
                      tomeNum: info.dealNum,
                      total: info.dealNum)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrierLists?.count ?? 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.registerSearchBar()
    }
}

//MARK: - load data
extension AddCarrierVC {
    
    func searchCarrierForAdd(search:String) -> Void {
        BaseApi.request(target: API.selectCarrier(search), type: BaseResponseModel<[ZbnFollowCarrierVo]>.self)
            .retry(2)
            .subscribe(onNext: { [weak self](data) in
                self?.carrierLists = data.data ?? []
                self?.tableView.reloadData()
            }, onError: { (error) in
                
            })
            .disposed(by: dispose)
    }
}


