
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
    
    private var searchQuery:SelectCarrierQueryModel = SelectCarrierQueryModel()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configEmptyView()
        tableViewRefreshState()
        self.fd_interactivePopDisabled = true
        self.addRightBarbuttonItem(withTitle: "取消")
        self.addLeftBarbuttonItem(withTitle: "")
        self.addLeftNaviHeader(placeholder: "请输入承运人电话号码")
        self.navigationItem.leftBarButtonItem?.isEnabled = false
    }
    
    override func zt_rightBarButtonAction(_ sender: UIBarButtonItem!) {
        self.pop()
    }
    
    override func currentSearchContent(content: String) {
        self.searchQuery.searchWord = content
        self.tableView.beginRefresh()
    }
}

//MARK: - config tableView
extension AddCarrierVC {
    func configTableView() -> Void {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.initEstmatedHeights()
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        self.registerCell(nibName: "\(MyCarrierInfoCell.self)", for: tableView)
    }
    
    func tableViewRefreshState() -> Void {
        tableView.pullRefresh()
        tableView.upRefresh()
        tableView.refreshAndLoadState()
            .subscribe(onNext: { [weak self](state) in
                if state == .LoadMore {
                    self?.loadMoreTableView()
                }
                if state == .Refresh {
                    self?.refreshTableView()
                }
            })
            .disposed(by: dispose)
        
    }
    
    func loadMoreTableView() -> Void {
        searchQuery.pageSize += 20
        searchCarrierForAdd()
    }
    
    func refreshTableView() -> Void {
        tableView.removeCacheHeights()
        searchQuery.pageSize = 20
        searchCarrierForAdd()
    }
    
    func configEmptyView() -> Void {
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    
    //MARK: - 点击发送邀请
    func tapInvate() -> Void {
        InviteAlertView.showInviteAlertView()
    }
    
    //MARK: - 添加承运人
    func addCarrier(index:Int) -> Void {
        let info = carrierLists![index]
        self.showLoading()
        BaseApi.request(target: API.addCarrier(info.carrierId ?? ""), type: BaseResponseModel<String>.self)
            .retry(2)
            .subscribe(onNext: {[weak self] (data) in
                self?.showSuccess(success: data.message, complete: nil)
                self?.carrierLists?.remove(at: index)
                self?.tableView.reloadData()
            }, onError: { [weak self](error) in
                self?.showFail(fail: error.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
    }
}

//MARK: -
extension AddCarrierVC {
    
    override func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        let title = "该承运人暂未注册，是否邀请注册?"
        let att = NSMutableAttributedString(string: title)
        att.addAttributes([NSAttributedStringKey.foregroundColor:UIColor(hex: "333333"),
                           NSAttributedStringKey.font:UIFont.systemFont(ofSize: 16)], range: NSRange(title) ?? NSRange(location: 0, length: title.count))
        return att
    }
    
    func buttonTitle(forEmptyDataSet scrollView: UIScrollView!, for state: UIControlState) -> NSAttributedString! {
        let title = "  发送邀请  "
        let att = NSMutableAttributedString(string: title)
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = 10
        paragraph.maximumLineHeight = 40
        paragraph.minimumLineHeight = 40
        att.addAttributes([NSAttributedStringKey.foregroundColor:UIColor(hex: "ffffff"),
                           NSAttributedStringKey.font:UIFont.systemFont(ofSize: 17),
                           NSAttributedStringKey.backgroundColor:UIColor(hex: "06C06F"),
                           NSAttributedStringKey.paragraphStyle:paragraph,
                           NSAttributedStringKey.baselineOffset:8], range: NSRange(title) ?? NSRange(location: 0, length: title.count))
        return att
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
                      total: info.dealSum,
                      style: .add)
        cell.handleClosure = {[weak self] in
            self?.addCarrier(index: indexPath.row)
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carrierLists?.count ?? 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.registerSearchBar()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.heightForRow(at: indexPath)
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        self.tapInvate()
    }
}

//MARK: - load data
extension AddCarrierVC {
    
    func searchCarrierForAdd() -> Void {
        BaseApi.request(target: API.selectCarrier(self.searchQuery), type:  BaseResponseModel<CarrierPageInfo<ZbnFollowCarrierVo>>.self)
            .retry(2)
            .subscribe(onNext: { [weak self](data) in
                self?.tableView.endRefresh()
                self?.carrierLists = data.data?.list ?? []
                self?.tableView.reloadData()
            },onError: { (error) in
                self.tableView.endRefresh()
            })
            .disposed(by: dispose)
        
       
    }
}


