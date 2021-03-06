//
//  GoodsSupplyDetailVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/28.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum GoodsSupplyStatus {
    case InBidding // 竞标中
    case OffShelve // 已下架
    case InShelveOnTime // 定时上架
    case Deal       // 已成交
    case Other      // 其他
}

class GoodsSupplyDetailVC: NormalBaseVC  {
    
    // 上级页面传过来的数据
    public var supplyDetail:GoodsSupplyListItem?

    // 请求的bean
    private var offerQueyBean:QuerySupplyDetailBean = QuerySupplyDetailBean()
    
    // 获取的数据
    private var pageContentInfo:OrderAndOffer?
    
    @IBOutlet weak var tableView: UITableView!
    
    private var currentSupplyStatus:GoodsSupplyStatus = .InBidding
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.offerQueyBean.hallId = self.supplyDetail?.id
        self.loadAllOffers()
        self.emptyTitle(title: "暂无报价", to: self.tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: lazy
    private lazy var bidingHeader:GSDetailBidingHeader = {
        return GoodsSupplyDetailVC.biddingHeaderInfoView()
    }() // 当为竞标中时，显示的header
    
    private var offShelveHeader:UIView?
    private var shelveTimerHeader:UIView?
    
    // config
    override func currentConfig() {
        weak var weakSelf = self
        self.view.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
        self.tableView.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let footerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: IPHONE_WIDTH, height: 60)))
        footerView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = footerView
        self.registerAllCells()
        self.tableView.separatorStyle = .none
        self.bidingHeader.bidingTapClosure = {state in
            weakSelf?.toAddHeader()
        }
    }
    
    override func bindViewModel() {
        self.tableView.rx.willDisplayCell
            .subscribe(onNext:{[weak self](cell ,index) in
                if self?.getGoodsSupplyStatus() == .InBidding {
                    cell.contentView.shadowBorder(radius: 5,
                                                  bgColor: UIColor.white,
                                                insets:UIEdgeInsetsMake(12, 15, 6, 15))
                }
            })
            .disposed(by: dispose)
        
        self.tableView.rx.itemSelected.asObservable()
            .subscribe(onNext: { [weak self](index) in
                if self?.getGoodsSupplyStatus() == .InBidding {
                    let item = self?.pageContentInfo?.offerPage?.list![index.row]
                    self?.showDealAldert(item: item)
                }
            })
            .disposed(by: dispose)
        
        self.tableView.refreshState.asObservable()
            .subscribe(onNext: { [weak self](state) in
                switch (state) {
                case .LoadMore:
                    self?.offerQueyBean.pageSize += 20
                    break;
                case .Refresh:
                    self?.offerQueyBean.pageSize = 20
                    break;
                default:
                    return
                }
                self?.loadAllOffers()
            }, onError: { (error) in
            })
            .disposed(by: dispose)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.bottomConfig()
    }
    
    deinit {
        print("detail de init ")
    }
}

// header
extension GoodsSupplyDetailVC {
    func toAddHeader() {
        if self.getGoodsSupplyStatus() == .InBidding {
            self.bidingHeader.bidingTapClosure = {[weak self] (state) in
                switch state {
                case .GSTapOffShelve:
                    self?.toOffShelveAlert()
                    break
                default:
                    self?.updateHeaderHeight()
                    break
                }
            }
            self.updateHeaderHeight()
            self.view.addSubview(self.bidingHeader)
        } else {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            self.bidingHeader.removeFromSuperview()
        }
    }
    
    func updateHeaderHeight() {
        let headerHeight = self.bidingHeader.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        self.bidingHeader.frame = CGRect(origin: .zero, size:CGSize(width: IPHONE_WIDTH, height:headerHeight))
        self.tableView.contentInset = UIEdgeInsetsMake(self.bidingHeader.zt_height, 0, 0, 0)
    }
}


// header view
extension GoodsSupplyDetailVC {
    
    // 当是竞标中的订单时 ，显示的头部竞标信息视图
    private static func biddingHeaderInfoView() -> GSDetailBidingHeader {
        let header = Bundle.main.loadNibNamed("\(GSDetailBidingHeader.self)", owner: nil, options: nil)?.first as! GSDetailBidingHeader
        header.foldHeader(isFolder: false)
        return header
    }
    
}

// cells
extension GoodsSupplyDetailVC {
    func registerAllCells() {
        self.registerCell(nibName: "\(GSDealedCell.self)", for: self.tableView)      // 已成交cell
        self.registerCell(nibName: "\(GSDetailInfoCell.self)", for: self.tableView)  // 货源详情
        self.registerCell(nibName: "\(GSTimerShelveCell.self)", for: self.tableView) // 按时上架cell
        self.registerCell(nibName: "\(GSOffShelveCell.self)", for: self.tableView)   // 竞价超时
        self.registerCell(nibName: "\(GSQutationCell.self)", for: self.tableView) // 竞价中时的cell
    }
}

extension GoodsSupplyDetailVC : UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        switch self.getGoodsSupplyStatus() {
        case .InBidding:
            return 1
        case .Deal:
            return 2
            
        case .InShelveOnTime:
            return 1
            
        case .OffShelve:
            return 1
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.getGoodsSupplyStatus() {
        case .InBidding:
            return self.pageContentInfo?.offerPage?.list?.count ?? 0
        case .Deal:
            return 1
            
        case .InShelveOnTime:
            return 1
            
        case .OffShelve:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.currentCell(tableView: tableView, indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if self.pageContentInfo?.zbnOrderHall?.isDeal == 0 {
            return 40
        }
        return 0.1
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.configTableViewSectionHeader()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footer = UIView()
        footer.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
        return footer
    }
}

// load data
extension GoodsSupplyDetailVC : UITableViewDelegate {
    
    //MARK: 获取数据
    func loadAllOffers() {
        self.showLoading()
        BaseApi.request(target: API.getOfferByOrderHallId(self.offerQueyBean), type: BaseResponseModel<OrderAndOffer?>.self)
            .subscribe(onNext: {[weak self] (data) in
                self?.showSuccess()
                self?.pageContentInfo = data.data!
                self?.toConfigHeaderInfo()
                self?.toAddHeader()
                self?.addRefresh()
                self?.tableView.reloadData()
            }, onError: {[weak self] (error) in
                self?.showFail(fail: error.localizedDescription, complete: nil)
            },onDisposed: {
                
            })
            .disposed(by: dispose)
    }
    
    // 手动上架
    func toOnShelve() {
        BaseApi.request(target: API.onShelf(self.pageContentInfo?.zbnOrderHall?.id ?? ""), type: BaseResponseModel<String>.self)
            .subscribe(onNext: {[weak self] (data) in
                self?.showSuccess()
                self?.loadAllOffers()
                }, onError: {[weak self] (error) in
                    self?.showFail(fail: error.localizedDescription, complete: nil)
            })
            .disposed(by: self.dispose)
    }
    
    func onShelveAlert() {
        AlertManager.showTitleAndContentAlert(title: nil, content: "该货源为定时上架货源，确定立即上架 ？") { [weak self](index) in
            if index == 1 {
                self?.toOnShelve()
            }
        }
    }
    
    // 手动下架
    func toOffShelve() {
        self.showLoading(title: "", complete: nil)
        let hallId = self.pageContentInfo?.zbnOrderHall?.id ?? ""
        BaseApi.request(target: API.undercarriage(hallId), type: BaseResponseModel<String>.self)
            .subscribe(onNext: {[weak self] (data) in
                self?.showSuccess()
                self?.loadAllOffers()
                }, onError: {[weak self] (error) in
                    self?.showFail(fail: error.localizedDescription, complete: nil)
                })
            .disposed(by: self.dispose)
    }
    
    func toOffShelveAlert() -> Void {
        AlertManager.showTitleAndContentAlert(title: "是否下架该条货源？", content: "已有报价的货源，下架自动驳回所有报价?") {[weak self](index) in
            if index == 1 {
                self?.toOffShelve()
            }
        }
    }
    
    // 手动成交
    func dealHall(item:SupplyOfferBean?) -> Void {
        if let item = item {
            self.showLoading(title: nil, complete: nil)
            BaseApi.request(target: API.orderHallManualTransaction(item.hallId ?? "", item.id ?? ""), type: BaseResponseModel<String>.self)
                .subscribe(onNext: { [weak self](data) in
                    self?.showSuccess(success: "货源已成交", complete: nil)
                    self?.loadAllOffers()
                }, onError: { [weak self](error) in
                    self?.showFail(fail: error.localizedDescription, complete: nil)
                })
                .disposed(by: dispose)
        }
    }
    
    func showDealAldert(item:SupplyOfferBean?) {
        let alertItem = GSConfirmAlertItem(name: item?.driverName, phone: item?.driverPhone, unit: item?.quotedPrice, total: item?.totalPrice, time: Double(item?.startTime ?? "0"), score: 5)
        GSConfirmDealView.showConfirmDealView(confirm: alertItem) {[weak self] (index) in
            if index == 1 {
                self?.dealHall(item: item)
            }
        }
    }
}

// 根据处理状态 ， 判断header
extension GoodsSupplyDetailVC {
    
    //MARK: 配置头部信息
    func toConfigHeaderInfo() {
        let hallInfo = self.pageContentInfo?.zbnOrderHall
        let end = Util.concatSeperateStr(seperete:"" , strs: hallInfo?.endProvince, hallInfo?.endCity , hallInfo?.endDistrict)
        let start = Util.concatSeperateStr(seperete:"" , strs: hallInfo?.startProvince, hallInfo?.startCity , hallInfo?.startDistrict)
        let sumer = Util.concatSeperateStr(strs: hallInfo?.goodsWeight, hallInfo?.vehicleWidth , hallInfo?.vehicleType ,hallInfo?.goodsType)
        let time = self.pageContentInfo?.surplusTurnoverTime
        let headerItem = BidingContentItem(autoDealTime: time, supplyCode: hallInfo?.stowageCode, startPlace: start, endPlace: end, loadTime: hallInfo?.loadingTime, goodsName: hallInfo?.goodsName, goodsType: hallInfo?.goodsType, goodsSummer: sumer, remark: hallInfo?.remark)
        self.bidingHeader.headerContent(item: headerItem)
    }
    
    // 当竞价中时，添加上拉加载和下拉刷新
    func addRefresh() -> Void {
        if self.pageContentInfo?.zbnOrderHall?.isDeal == 0 {
            self.tableView.pullRefresh()
            self.tableView.upRefresh()
        }
    }
    
    func getGoodsSupplyStatus() -> GoodsSupplyStatus {
        //0=竞价中 1=成交 2=未上架 3=已下
        if self.pageContentInfo?.zbnOrderHall?.isDeal == 0 {
            return GoodsSupplyStatus.InBidding
        }
        if self.pageContentInfo?.zbnOrderHall?.isDeal == 1 {
            return GoodsSupplyStatus.Deal
        }
        if self.pageContentInfo?.zbnOrderHall?.isDeal == 2 {
            return GoodsSupplyStatus.InShelveOnTime
        }
        if self.pageContentInfo?.zbnOrderHall?.isDeal == 3 {
            return GoodsSupplyStatus.OffShelve
        }
        return .Other
    }
    
    func configTableViewSectionHeader() -> UIView? {
        if self.pageContentInfo?.zbnOrderHall?.isDeal == 0 {
            let header = Bundle.main.loadNibNamed("GSDetailBidingHeader", owner: nil, options: nil)![1] as! GoodsInBidingHeader
            
            return header
        }
        return nil
    }
    
    func obtainDealedOffer() -> SupplyOfferBean? {
        let offers = self.pageContentInfo?.offerPage?.list?.filter({ (bean) -> Bool in
            return bean.dealStatus == 2
        })
        return offers?.first
    }
    
    func currentCell(tableView:UITableView , indexPath:IndexPath) -> UITableViewCell {
        switch self.getGoodsSupplyStatus() {
        case .InBidding:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(GSQutationCell.self)") as! GSQutationCell
            let item = self.pageContentInfo?.offerPage?.list![indexPath.row]
            cell.contentInfo(item: item)
            cell.dealClosure = { [weak self](item) in
                self?.showDealAldert(item: item)
            }
            return cell
        case .Deal:
            let info = self.pageContentInfo?.zbnOrderHall
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(GSDealedCell.self)") as! GSDealedCell
                cell.contentInfo(info: info , offer: self.obtainDealedOffer())
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(GSDetailInfoCell.self)") as! GSDetailInfoCell
            cell.contentInfo(info: info)
            return cell
            
        case .InShelveOnTime:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(GSTimerShelveCell.self)") as! GSTimerShelveCell
            let info = self.pageContentInfo?.zbnOrderHall
            cell.contentInfo(info: info)
            return cell
            
        case .OffShelve:
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(GSOffShelveCell.self)") as! GSOffShelveCell
            let info = self.pageContentInfo?.zbnOrderHall
            cell.contentInfo(info: info)
            return cell
        default:
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
    }
    
    //
    func bottomConfig() {
        switch self.getGoodsSupplyStatus() {
        case .InBidding:
            self.bottomButtom(titles: [], targetView: self.tableView)
            break
        case .Deal:
            self.bottomButtom(titles: ["查看运单"], targetView: self.tableView)
            break;
            
        case .InShelveOnTime:
            self.bottomButtom(titles: ["立即上架"], targetView: self.tableView) { [weak self](index) in
                self?.onShelveAlert()
            }
            break
            
        case .OffShelve:
            self.bottomButtom(titles: ["重新上架"], targetView: self.tableView) { [weak self](index) in
                self?.onShelveAlert()
            }
            break
        default:
            self.bottomButtom(titles: [], targetView: self.tableView)
            break
        }
    }
}
