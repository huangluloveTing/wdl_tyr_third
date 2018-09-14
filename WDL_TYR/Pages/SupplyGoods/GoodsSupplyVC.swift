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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wr_setNavBarShadowImageHidden(true)
        self.addNaviHeader()
        self.addMessageRihgtItem()
        if #available(iOS 11.0, *) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentBehavior.never
        } else {
            self.tableView.translatesAutoresizingMaskIntoConstraints = false
        }
        self.emptyTitle(title: "暂无货源", to: self.tableView)
    }
    
    override func currentConfig() {
        self.tableView.register(UINib.init(nibName: goodsSupplyCellIdentity, bundle: nil), forCellReuseIdentifier: goodsSupplyCellIdentity)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        self.bottomButtom(titles: ["取消" ,"确定"], targetView: self.tableView)
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
        
        let deleteCommand = tableView.rx.itemDeleted.asDriver()
            .map(SupplyGoodsCommand<MyHeaderSections>.ItemDelete)
        let itemCommand = tableView.rx.itemSelected.asDriver()
            .map { (indexPath) in
                SupplyGoodsCommand<MyHeaderSections>.TapItem(indexPath, self)
            }
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
                let dataObserval = BaseApi.request(target: API.ownOrderHall(self.requestBean), type: BaseResponseModel<GoodsSupplyList>.self)
                    .subscribeOn(MainScheduler.instance)
                    .catchErrorJustReturn(BaseResponseModel<GoodsSupplyList>())
                return dataObserval
            }
            .asDriver(onErrorJustReturn: BaseResponseModel<GoodsSupplyList>())
            .map { (model) -> SupplyGoodsCommand<MyHeaderSections> in
                self.tableView.endRefresh()
                return SupplyGoodsCommand.Refresh(items: [MyHeaderSections(header: "", items: model.data?.list ?? [])])
            }
        
        Observable.of(deleteCommand , itemCommand , refreshCommand)
            .merge()
            .scan(initailState) { (state, command) -> GoodsSupplyState in
                return state.excute(command:command)
            }
            .startWith(initailState)
            .map { (state) in
                state.sections
            }
            .share(replay: 1)
            .bind(to: tableView.rx.items(dataSource: ds))
            .disposed(by: dispose)
        
    }
    
    // 状态下拉视图
    private lazy var statusView:DropViewContainer = {
       let statusView = GoodsSupplyStatusDropView(tags: ["不限","已成交","竞价中","已上架","未上架"])
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
            self.startButton.setTitle(strict?.title, for: .normal)
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
            self.endButton.setTitle(strict?.title, for: .normal)
        }
        return self.addDropView(drop: placeView, anchorView: dropAnchorView)
    }()
}

// 获取数据
extension GoodsSupplyVC : UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.heightForRow(at: indexPath)
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
    // 获取DataSource
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
        return Util.configServerRegions(regions: WDLCoreManager.shared().regionAreas ?? [])
    }
}

struct GoodsSupplyState {
    var sections:[MyHeaderSections]
    
    init(sections:[MyHeaderSections]) {
        self.sections = sections
    }
    
    func excute(command:SupplyGoodsCommand<MyHeaderSections>) -> GoodsSupplyState {
        switch command {
            case .TapItem( _ , let vc):
                    vc.toGoodsSupplyDetail()
                    return self
            case .ItemDelete(let indexPath):
                var sections = self.sections
                var section = self.sections[indexPath.section]
                var items = section.items
                items.remove(at: indexPath.row)
                section.items = items
                sections[indexPath.section] = section
                return GoodsSupplyState(sections: sections)
            case .Refresh(items: let items):
                return GoodsSupplyState(sections: items)
            default:
                return GoodsSupplyState(sections: self.sections)
        }
    }
}

struct MyHeaderSections  {
    var header:String
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
