//
//  WayBillVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/24.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class WayBillVC: MainBaseVC {
    
    // 运单状态 1=待起运 0=待办单 2=运输中 3=已签收 4=被拒绝
    private let transportStatus = ["不限"/*,"待办单"*/,"待起运","运输中","待签收", "已签收"]
    
    private let transportStatus_agency = ["不限","待办单","待起运","运输中","待签收", "已签收"]

    @IBOutlet weak var dropAnchorView: UIView!
    @IBOutlet weak var statusButton: MyButton!
    @IBOutlet weak var endButton: MyButton!
    @IBOutlet weak var startButton: MyButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var startPlaceView:DropPlaceChooiceView?
    private var endPlaceView:DropPlaceChooiceView?
    
    private var startModel:SupplyPlaceModel = SupplyPlaceModel()
    private var endModel:SupplyPlaceModel = SupplyPlaceModel()
    private var listStatus:GoodsSupplyStatus?
    private var queryBean : QuerytTransportListBean = QuerytTransportListBean()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wr_setNavBarShadowImageHidden(true)
        self.addNaviHeader(placeholder: "搜索我的运单(运单号、承运人、车牌号、线路)")
        self.addMessageRihgtItem()
        self.emptyTitle(title: "暂无运单", to: self.tableView)
        self.hiddenTableViewSeperate(tableView: self.tableView)
        self.tableView.beginRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.beginRefresh()
        if WDLCoreManager.shared().regionAreas == nil || WDLCoreManager.shared().regionAreas?.count == 0 {
            self.loadAllAreaAndStore {
                self.startPlaceView?.placeItems = self.initialProinve()
                self.endPlaceView?.placeItems = self.initialProinve()
            }
        }
    }
    
    override func currentConfig() {
        self.registerCells()
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
        self.tableView.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func bindViewModel() {
        self.tableView.upRefresh()
        self.tableView.pullRefresh()
        self.statusButton.rx.tap
            .subscribe(onNext: { () in
                self.showStatusDropView()
            })
            .disposed(by: dispose)
        self.endButton.rx.tap.asObservable()
            .subscribe(onNext: { () in
                self.showEndPlaceDropView()
            })
            .disposed(by: dispose)
        self.startButton.rx.tap.asObservable()
            .subscribe(onNext: { () in
                self.showPlaceDropView()
            })
            .disposed(by: dispose)
        self.tableView.rx.willDisplayCell
            .subscribe(onNext:{(cell , indexPath) in
                cell.contentView.shadowBorder(radius: 4, bgColor: UIColor.white , insets:UIEdgeInsetsMake(15, 15, 0, 15))
            })
            .disposed(by: dispose)
        
        self.tableView.rx.itemSelected.asObservable()
            .subscribe(onNext: { (indexPath) in
            })
            .disposed(by: dispose)
        
        let itemSelectCommand = self.tableView.rx.itemSelected.asObservable().map { (indexPath) -> WayBillExcuteCommand in
                return WayBillExcuteCommand.selectedItem(indexPath, self)
            }
        let itemDeleteCommand = self.tableView.rx.itemDeleted.asObservable().map(WayBillExcuteCommand.deleteItem)
        let loadDataCommand = self.handleCommand().map { [weak self](lists) -> WayBillExcuteCommand in
            self?.tableView.endRefresh()
            let wayBillSections = WayBillSections(header: "", items: lists.list ?? [])
            if lists.list?.count ?? 0 >= lists.total {
                self?.tableView.noMore()
            }
            return WayBillExcuteCommand.refresh([wayBillSections])
        }
        
       let disposable = Observable.of(itemDeleteCommand , itemSelectCommand , loadDataCommand)
            .merge()
            .scan(WayBillExcuteState(sections: []), accumulator: { (state, command) -> WayBillExcuteState in
                state.excute(command: command)
            })
            .map { (state) -> [WayBillSections] in
                return state.sections
            }
            .share(replay: 1)
            .bind(to: self.tableView.rx.items(dataSource: self.instanceDataSource()))
        
        disposable.disposed(by: dispose)
    }
    
    func registerCells() {
        self.registerCell(nibName: "\(WayBillCell.self)", for: self.tableView)
    }
    
    //MARK: - drop
    // 状态下拉视图
    private lazy var statusView:DropViewContainer = {
        let statusView = GoodsSupplyStatusDropView(tags: WDLCoreManager.shared().consignorType == .third ? transportStatus : transportStatus_agency)
        // 0=待办单（经销商有此状态） 1=待起运 2=运输中 3=代签收 10=已签收
        // transportStatus (integer): 运单状态 0=待办单（经销商有此状态） 1=待起运 2=运输中 3=代签收 10=已签收
        statusView.checkClosure = { [weak self] (index) in
            let statusTitles =  WDLCoreManager.shared().consignorType == .third ? self?.transportStatus : self?.transportStatus_agency
            self?.statusButton.setTitle(statusTitles![index], for: .normal)
            // transportStatus (integer): 运单状态 1=待起运 2=运输中 3=代签收 10=已签收 // 托运人
            if WDLCoreManager.shared().consignorType == .third {
                if index == 0 {
                    self?.queryBean.transportStatus = nil
                } else if index == 4 {
                    self?.queryBean.transportStatus = 10
                } else {
                    self?.queryBean.transportStatus = index
                }
            } else { // 经销商
                if index == 0 {
                    self?.queryBean.transportStatus = nil
                } else if index == 1 {
                    self?.queryBean.transportStatus = 0
                } else if index == 5 {
                    self?.queryBean.transportStatus = 10
                } else {
                    self?.queryBean.transportStatus = index - 1
                }
            }
            self?.showStatusDropView()
            self?.tableView.beginRefresh()
        }
        return self.addDropView(drop: statusView, anchorView: self.dropAnchorView)
    }()
    
    //选择开始地区的下拉视图
    private lazy var placeChooseView:DropViewContainer = {
        let placeView = Bundle.main.loadNibNamed("DropPlaceView", owner: nil, options: nil)?.first as! DropPlaceChooiceView
        placeView.placeItems = self.initialProinve()
        placeView.frame = CGRect(x: 0, y: 0, width: IPHONE_WIDTH, height: IPHONE_WIDTH)
        placeView.dropClosure = { [weak self](province , city , strict) in
            self?.startModel.province = province
            self?.startModel.city = city
            self?.startModel.strict = strict
            self?.startButton.setTitle(strict?.title ?? (city?.title ?? province?.title), for: .normal)
        }
        placeView.decideClosure = { [weak self](sure) in
            if sure == true {
                let strict = self?.startModel.strict
                self?.startButton.setTitle(self?.startModel.strict?.title ?? (self?.startModel.city?.title ?? self?.startModel.province?.title), for: .normal)
            } else {
                self?.startModel = SupplyPlaceModel()
                self?.startButton.setTitle("发货地", for: .normal)
            }
            self?.showPlaceDropView()
            self?.tableView.beginRefresh()
        }
        self.startPlaceView = placeView
        return self.addDropView(drop: placeView, anchorView: dropAnchorView)
    }()
    
    //选择终点地区的下拉视图
    private lazy var endPlaceChooseView:DropViewContainer = {
        let placeView = Bundle.main.loadNibNamed("DropPlaceView", owner: nil, options: nil)?.first as! DropPlaceChooiceView
        placeView.placeItems = self.initialProinve()
        placeView.frame = CGRect(x: 0, y: 0, width: IPHONE_WIDTH, height: IPHONE_WIDTH)
        placeView.dropClosure = { (province , city , strict) in
            self.endModel.province = province
            self.endModel.city = city
            self.endModel.strict = strict
            self.endButton.setTitle(strict?.title ?? (city?.title ?? province?.title), for: .normal)
        }
        placeView.decideClosure = { [weak self](sure) in
            if sure == true {
                let strict = self?.endModel.strict
                self?.endButton.setTitle(self?.endModel.strict?.title ?? (self?.endModel.city?.title ?? self?.endModel.province?.title), for: .normal)
            } else {
                self?.endModel = SupplyPlaceModel()
                self?.endButton.setTitle("收货地", for: .normal)
            }
            self?.showEndPlaceDropView()
            self?.tableView.beginRefresh()
        }
        self.endPlaceView = placeView
        return self.addDropView(drop: placeView, anchorView: dropAnchorView)
    }()
    
    //MARK: -
    override func currentSearchContent(content: String) {
        self.queryBean.searchWord = content
        self.tableView.beginRefresh()
    }
}

// observable
extension WayBillVC {
    
    func handleCommand() -> Observable<WayBillPageBean> {
       return self.tableView.refreshState.asObservable()
            .distinctUntilChanged()
            .filter { (state) -> Bool in
                if state == .Refresh {
                    self.tableView.resetFooter()
                }
                return state != TableViewState.EndRefresh
            }
            .flatMap { (state) -> Observable<WayBillPageBean> in
                if state == .LoadMore {
                    self.queryBean.pageSize += 20
                }
                if state == .Refresh {
                    self.queryBean.pageSize = 20
                }
                return self.loadWayBill().asObservable()
            }
    }
    
    func loadWayBill() -> Observable<WayBillPageBean> {
        
        self.queryBean.startCity = Util.mapSpecialStrToNil(str: self.startModel.city?.title)
        self.queryBean.startDistrict = Util.mapSpecialStrToNil(str: self.startModel.strict?.title)
        self.queryBean.startProvince = Util.mapSpecialStrToNil(str: self.startModel.province?.title)
        self.queryBean.endCity = Util.mapSpecialStrToNil(str: self.endModel.city?.title)
        self.queryBean.endDistrict = Util.mapSpecialStrToNil(str: self.endModel.strict?.title)
        self.queryBean.endProvince = Util.mapSpecialStrToNil(str: self.endModel.province?.title)
        
        let result = BaseApi.request(target: API.ownTransportPage(self.queryBean), type: BaseResponseModel<WayBillPageBean>.self)
            .retry(2)
            .catchErrorJustReturn(BaseResponseModel<WayBillPageBean>())
            .map { (data) -> WayBillPageBean in
                return data.data ?? WayBillPageBean()
            }
        return result
    }
}

// cell height
extension WayBillVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView.removeCacheHeights(withIndexPaths: [indexPath])
        return tableView.heightForRow(at: indexPath)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        registerSearchBar()
    }
}


// DataSource
extension WayBillVC {
    func instanceDataSource() -> RxTableViewSectionedReloadDataSource<WayBillSections> {
        let datasource = RxTableViewSectionedReloadDataSource<WayBillSections>(
            configureCell: {(dataSource , ts , indexPath , item) -> UITableViewCell in
                let cell = ts.dequeueReusableCell(withIdentifier: "\(WayBillCell.self)") as! WayBillCell
                cell.contentInfo(info: item)
                return cell
            })
        return datasource
    }
    
    //MARK:
    func initialProinve() -> [PlaceChooiceItem] {
        var items = Util.configServerRegions(regions: WDLCoreManager.shared().regionAreas ?? [])
        let all = PlaceChooiceItem(title: "全国", id: "", selected: false, subItems: nil, level: 0)
        items.insert(all, at: 0)
        return items
    }
}


enum WayBillExcuteCommand {
    case selectedItem(IndexPath , BaseVC)
    case deleteItem(IndexPath)
    case refresh([WayBillSections])
    case loadMore([WayBillSections])
}

struct WayBillExcuteState {
    var sections:[WayBillSections]
    
    init(sections:[WayBillSections]) {
        self.sections = sections
    }
    
    func excute(command:WayBillExcuteCommand) -> WayBillExcuteState {
        switch command {
        case .deleteItem(let indexPath):
            var newSections = sections
            newSections[indexPath.section].items.remove(at: indexPath.row)
            return WayBillExcuteState(sections: newSections)
            
        case .selectedItem(let indexPath  ,let vc):
            vc.toWayBillDetail(wayBillInfo: self.sections[indexPath.section].items[indexPath.row])
            return WayBillExcuteState(sections: self.sections)
            
        case .refresh(let newSections):
            return WayBillExcuteState(sections: newSections)
        case .loadMore(let newSections):
            return WayBillExcuteState(sections: newSections)
        }
    }
}


struct WayBillSections  {
    var header:String
    var items:[WayBillInfoBean]
}

extension WayBillSections : AnimatableSectionModelType {
    var identity: String {
        return header
    }
    
    typealias Item = WayBillInfoBean
    
    init(original: WayBillSections, items: [Item]) {
        self = original
        self.items = items
    }
}


// 添加 下拉选项 操作
extension WayBillVC {
    
    func showStatusDropView() {
        self.placeChooseView.hiddenDropView()
        self.endPlaceChooseView.hiddenDropView()
        if self.statusView.isShow == false {
            self.statusView.showDropViewAnimation()
        } else {
            self.statusView.hiddenDropView()
        }
    }
    
    func showPlaceDropView() {
        self.statusView.hiddenDropView()
        self.endPlaceChooseView.hiddenDropView()
        if self.placeChooseView.isShow == false {
            self.placeChooseView.showDropViewAnimation()
        } else {
            self.placeChooseView.hiddenDropView()
        }
    }
    
    func showEndPlaceDropView() {
        self.statusView.hiddenDropView()
        self.placeChooseView.hiddenDropView()
        if self.endPlaceChooseView.isShow == false {
            self.endPlaceChooseView.showDropViewAnimation()
        } else {
            self.endPlaceChooseView.hiddenDropView()
        }
    }
}


