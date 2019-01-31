//
//  GoodsSupplyVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/24.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

let goodsSupplyCellIdentity = "\(GoodsSupplyCell.self)"

struct SupplyPlaceModel {
    var province:PlaceChooiceItem?
    var city : PlaceChooiceItem?
    var strict : PlaceChooiceItem?
}


class GoodsSupplyVC: MainBaseVC {
    
    @IBOutlet weak var endButton: MyButton!
    @IBOutlet weak var startButton: MyButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusButton: MyButton!
    @IBOutlet weak var dropAnchorView: UIView!
  
    private var startModel:SupplyPlaceModel = SupplyPlaceModel()
    private var endModel:SupplyPlaceModel = SupplyPlaceModel()
    private var listStatus:GoodsSupplyStatus?
    private var requestBean:GoodsSupplyQueryBean = GoodsSupplyQueryBean()
    private var currentLists:[GoodsSupplyListItem] = []
    
    //删除cell的数据闭包
    typealias DeleteCellItemsColsure = (_ items: [GoodsSupplyListItem]) -> Void
    //删除cell的数据闭包
    var deleteCellItemsColsure: DeleteCellItemsColsure?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wr_setNavBarShadowImageHidden(true)
        self.addNaviHeader(placeholder: "搜索我的货源(货源名称、承运人、线路)")

        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        } else {
            self.tableView.translatesAutoresizingMaskIntoConstraints = false
        }
        self.emptyTitle(title: "暂无货源", to: self.tableView)
        self.addMessageRihgtItem()
        registerMessageNotification()
    }

    override func receiveMessageResultHandler() {
        getMessageNumRequest()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.wr_setNavBarBarTintColor(UIColor(hex: "06C06F"))
        //设置消息个数
        self.getMessageNumRequest()
        self.tableView.beginRefresh()
        if WDLCoreManager.shared().regionAreas == nil || WDLCoreManager.shared().regionAreas?.count == 0 {
            self.loadAllAreaAndStore()
        }
    }
   
    override func currentConfig() {
        self.tableView.register(UINib.init(nibName: goodsSupplyCellIdentity, bundle: nil), forCellReuseIdentifier: goodsSupplyCellIdentity)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableView.pullRefresh()
        self.tableView.upRefresh()
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 0
        self.tableView.estimatedSectionFooterHeight = 0
        self.tableView.estimatedSectionHeaderHeight = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //MARK: - bindViewModel
    override func bindViewModel() {
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
        
        let ds = GoodsSupplyVC.getDataSource()
    
        tableView.rx.willDisplayCell
            .subscribe(onNext:{ (tc , index) in
                let cell = tc as! GoodsSupplyCell
                cell.containerView.shadowBorder(radius: 5 , bgColor: UIColor.white, width:IPHONE_WIDTH - 40)
            })
            .disposed(by: dispose)
        
    
        //删除的内容
        let deleteCommand = tableView.rx.itemDeleted.asDriver()
            .map { [weak self](indexPath) -> Observable<IndexPath> in
                return Observable<IndexPath>.create({ (observer) -> Disposable in
                    
                    AlertManager.showTitleAndContentAlert(context:self!, title: "提示", content: "是否确认删除该货源？", closure: { (index) in
                        if index == 1 {
                            self?.deleteDataRequest(indexPath: indexPath, closure: { (error) in
                                guard let _ = error else {
                                    observer.onNext(indexPath)
                                    observer.onCompleted()
                                    return
                                }
                                observer.onCompleted()
                            })
                            
                        }
                    })
                    
                    return Disposables.create()
                    
                })
            }
            .asObservable().flatMap { $0 }
            .map(SupplyGoodsCommand<MyHeaderSections>.ItemDelete)
        
        
        let itemCommand = tableView.rx.itemSelected.asDriver()
            .map { (indexPath) in
                SupplyGoodsCommand<MyHeaderSections>.TapItem(indexPath, self)
            }
            .asObservable()
        
        let initailState = GoodsSupplyState(sections: [
                MyHeaderSections(header: "", items: [])
            ])
        
        
        
        /**
         * rxSwfit 主要是观察者和被观察者的关系
         * Observer(观察者) 观察 Observable（被观察者） 的变化，并作出对应的响应
         * rxSwift 主要理解 函数式编程的思想 ， 所有的信息都是信息流，一层一层往下走
         */
        let refreshCommand = self.tableView.refreshState.asObservable()
            .distinctUntilChanged()
            .filter({ (state) -> Bool in
                return state != TableViewState.EndRefresh
            })
            .flatMap { (state) -> Observable<BaseResponseModel<GoodsSupplyList>> in
                if state == TableViewState.Refresh {
                    self.requestBean.pageSize = 20
                }
                if state == TableViewState.LoadMore {
                    self.requestBean.pageSize += 20
                }
                
                self.requestBean.startCity = Util.mapSpecialStrToNil(str: self.startModel.city?.title)
                self.requestBean.startProvince = Util.mapSpecialStrToNil(str: self.startModel.province?.title)
                self.requestBean.endCity = Util.mapSpecialStrToNil(str: self.endModel.city?.title)
                self.requestBean.endProvince = Util.mapSpecialStrToNil(str: self.endModel.province?.title)
                
                let dataObserval = BaseApi.request(target: API.ownOrderHall(self.requestBean), type: BaseResponseModel<GoodsSupplyList>.self)
                    .retry(2)
                    .subscribeOn(MainScheduler.instance)
                    .catchErrorJustReturn(BaseResponseModel<GoodsSupplyList>())
                return dataObserval
            }
            .asDriver(onErrorJustReturn: BaseResponseModel<GoodsSupplyList>())
            .asObservable()
            .map { [weak self](model) -> SupplyGoodsCommand<MyHeaderSections> in
                self?.tableView.endRefresh()
                self?.currentLists = model.data?.list ?? []
                return SupplyGoodsCommand.Refresh(items: [MyHeaderSections(header: "", items: self?.currentLists ?? [])])
            }
        
        Observable.of(deleteCommand , itemCommand , refreshCommand)
            .merge()
            .scan(initailState) { (state, command) -> GoodsSupplyState in
                return state.excute(command: command)
            }
            .startWith(initailState)
            .map { (state) in
                state.sections
            }
            .share(replay: 1)
            .bind(to: tableView.rx.items(dataSource: ds))
            .disposed(by: dispose)
        
    }
    
  
    //MARK: - drop
    // 状态下拉视图
    private lazy var statusView:DropViewContainer = {
        var statusView = GoodsSupplyStatusDropView(tags: GoodsStatus)
        let type = WDLCoreManager.shared().consignorType
            //第三方
          if type == .third {
            statusView = GoodsSupplyStatusDropView(tags: GoodsStatus)
          }else{
            //经销商
            statusView = GoodsSupplyStatusDropView(tags: AgentGoodsStatus)
          }
        
        //0=竞价中 1=成交 2=未上架 3=已下架,未成交
        statusView.checkClosure = { [weak self] (index) in
            if index == 0 {
                self?.requestBean.isDeal = nil
            }
            if type == .third {
                self?.statusButton.setTitle(GoodsStatus[index], for: .normal)
                self?.requestBean.isDeal = index - 1
            }else{
                self?.statusButton.setTitle(AgentGoodsStatus[index], for: .normal)
                if self?.statusButton.titleLabel?.text == "未成交"{
                    self?.requestBean.isDeal = 3
                }else{
                    self?.requestBean.isDeal = index - 1
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
        placeView.dropClosure = { (province , city , strict) in
            self.startModel.province = province
            self.startModel.city = city
            self.startModel.strict = strict
            self.startButton.setTitle(city?.title ?? ( province?.title), for: .normal)
        }
        placeView.decideClosure = { [weak self](sure) in
            if sure == true {
                let strict = self?.startModel.strict
                self?.startButton.setTitle(self?.startModel.city?.title ?? self?.startModel.province?.title, for: .normal)
            } else {
                self?.startModel = SupplyPlaceModel()
                self?.startButton.setTitle("发货地", for: .normal)
            }
            self?.showPlaceDropView()
            self?.tableView.beginRefresh()
        }
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
            self.endButton.setTitle(city?.title ?? (province?.title), for: .normal)
        }
        placeView.decideClosure = { [weak self](sure) in
            if sure == true {
                let strict = self?.endModel.strict
                self?.endButton.setTitle(self?.endModel.city?.title ?? self?.endModel.province?.title, for: .normal)
            } else {
                self?.endModel = SupplyPlaceModel()
                self?.endButton.setTitle("收货地", for: .normal)
            }
            self?.showEndPlaceDropView()
            self?.tableView.beginRefresh()
        }
        return self.addDropView(drop: placeView, anchorView: dropAnchorView)
    }()
    
    //MARK: -
    override func currentSearchContent(content: String) {
        self.requestBean.searchWord = content
        self.tableView.beginRefresh()
    }
    
    override func currentSearchOnTimeContent(content: String) {
        self.requestBean.searchWord = content
    }
}

// 获取数据
extension GoodsSupplyVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.heightForRow(at: indexPath)
       
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        registerSearchBar()
    }
}

// 添加 下拉选项 操作
extension GoodsSupplyVC {
    
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


extension GoodsSupplyVC {
    
    // 获取DataSource  创建表格数据源
    static func getDataSource() -> RxTableViewSectionedAnimatedDataSource<MyHeaderSections> {
        let _dataSource = RxTableViewSectionedAnimatedDataSource<MyHeaderSections>(animationConfiguration: AnimationConfiguration(
                insertAnimation: .top,
                reloadAnimation: .fade,
                deleteAnimation: .top),
                configureCell: {
                    (dataSource, tv, indexPath, element) in
                    let cell = tv.dequeueReusableCell(withIdentifier: goodsSupplyCellIdentity)! as! GoodsSupplyCell
                    cell.showContent(item: element)
                    return cell
                },
                canEditRowAtIndexPath : { (datasource , indexpath) in
                    return true
                })
        return _dataSource
    }
    
    //MARK: 
    func initialProinve() -> [PlaceChooiceItem] {
        var items = Util.configServerRegions(regions: WDLCoreManager.shared().regionAreas ?? [])
        let all = PlaceChooiceItem(title: "全国", id: "", selected: false, subItems: nil, level: 0)
        items.insert(all, at: 0)
        return items
    }
}

//MARK: - 删除数据
extension GoodsSupplyVC {
    
    func deleteDataRequest(indexPath: IndexPath , closure:((Error?) -> ())?) {
        let item = self.currentLists[indexPath.row]
        //货物id
        let hallId = item.id ?? ""
        //只有未上架和已下架才可以删除
        BaseApi.request(target: API.deleteOrderHall(hallId), type: BaseResponseModel<String>.self)
            .subscribe(onNext: { [weak self](data) in
                self?.currentLists.remove(at: indexPath.row)
                if let closure = closure {
                    closure(nil)
                }
            }, onError: { [weak self](error) in
                self?.showFail(fail: error.localizedDescription, complete: nil)
                if let closure = closure {
                    closure(error)
                }
            })
            .disposed(by: dispose)
    }
}

struct GoodsSupplyState {
    var sections:[MyHeaderSections]
    
    init(sections:[MyHeaderSections]) {
        self.sections = sections
    }
    
    func excute(command:SupplyGoodsCommand<MyHeaderSections>) -> GoodsSupplyState {
        switch command {
        case .TapItem(let indexPath , let vc):
                    let item = self.sections[indexPath.section].items[indexPath.row]
                    vc.toGoodsSupplyDetail(item: item)
                    return self
        case .ItemDelete(let indexPath):
                var sections = self.sections
                var section = self.sections[indexPath.section]
                var items = section.items
//                let item = items[indexPath.row]
                items.remove(at: indexPath.row)
                section.items = items
                sections[indexPath.section] = section;
                return GoodsSupplyState(sections: sections)
            
            case .Refresh(items: let items):
                return GoodsSupplyState(sections: items)
            default:
                return GoodsSupplyState(sections: self.sections)
        }
    }

}



struct MyHeaderSections  {
    //标识
    var header:String
    //model数组
    var items:[GoodsSupplyListItem]
}

extension MyHeaderSections : AnimatableSectionModelType {
    var identity: String {
        return header
    }

    typealias Item = GoodsSupplyListItem

    init(original: MyHeaderSections, items: [Item]) {
        self = original
        self.items = items
    }
}
