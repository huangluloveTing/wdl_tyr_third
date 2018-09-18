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

    @IBOutlet weak var tableView: UITableView!
    
    private var queryBean : QuerytTransportListBean = QuerytTransportListBean()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wr_setNavBarShadowImageHidden(true)
        self.addNaviHeader()
        self.addMessageRihgtItem()
        self.emptyTitle(title: "暂无运单", to: self.tableView)
        self.hiddenTableViewSeperate(tableView: self.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.beginRefresh()
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
        let loadDataCommand = self.handleCommand().map { (lists) -> WayBillExcuteCommand in
            self.tableView.endRefresh()
            let wayBillSections = WayBillSections(header: "", items: lists.list ?? [])
            return WayBillExcuteCommand.refresh([wayBillSections])
        }
        
        Observable.of(itemDeleteCommand , itemSelectCommand , loadDataCommand)
            .merge()
            .scan(WayBillExcuteState(sections: []), accumulator: { (state, command) -> WayBillExcuteState in
                state.excute(command: command)
            })
            .map { (state) -> [WayBillSections] in
                return state.sections
            }
            .bind(to: self.tableView.rx.items(dataSource: self.instanceDataSource()))
            .disposed(by: dispose)
    }
    
    func registerCells() {
        self.registerCell(nibName: "\(WayBillCell.self)", for: self.tableView)
    }
}

// observable
extension WayBillVC {
    
    func handleCommand() -> Observable<WayBillPageBean> {
       return self.tableView.refreshState.asObservable()
            .filter { (state) -> Bool in
                return state != TableViewState.EndRefresh
            }
            .flatMap { (state) -> Observable<WayBillPageBean> in
                return self.loadWayBill().asObservable()
            }
    }
    
    func loadWayBill() -> Observable<WayBillPageBean> {
        let result = BaseApi.request(target: API.ownTransportPage(self.queryBean), type: BaseResponseModel<WayBillPageBean>.self)
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
        return tableView.heightForRow(at: indexPath)
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




