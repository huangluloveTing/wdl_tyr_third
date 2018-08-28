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

class GoodsSupplyVC: MainBaseVC {
    
//    private var _items:[AnimatableSectionModel<String, String>]?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusButton: MyButton!
    @IBOutlet weak var dropAnchorView: UIView!
    
//    private var deleteCommand:?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wr_setNavBarShadowImageHidden(true)
        self.addNaviHeader()
        self.addMessageRihgtItem()
    }
    
    override func currentConfig() {
        self.tableView.register(UINib.init(nibName: goodsSupplyCellIdentity, bundle: nil), forCellReuseIdentifier: goodsSupplyCellIdentity)
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.none
        let headerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: IPHONE_WIDTH, height: 10)))
        let footerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: IPHONE_WIDTH, height: 10)))
        headerView.backgroundColor = UIColor(hex: "EEEEEE")
        footerView.backgroundColor = UIColor(hex: "EEEEEE")
        self.tableView.tableHeaderView = headerView
        self.tableView.tableFooterView = footerView
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
        
        let ds = GoodsSupplyVC.getDataSource()
        
        tableView.rx.willDisplayCell
            .subscribe(onNext:{ (tc , index) in
                let cell = tc as! GoodsSupplyCell
                cell.containerView.shadowBorder(radius: 5 , bgColor: UIColor.white, width:IPHONE_WIDTH - 40)
            })
            .disposed(by: dispose)
        
        let deleteCommand = tableView.rx.itemDeleted
            .map(SupplyGoodsCommand.ItemDelete)
        let itemCommand = tableView.rx.itemSelected
            .map(SupplyGoodsCommand.TapItem)
        let initailState = GoodsSupplyState(sections: [
                MyHeaderSections(header: "", items: [
                    "不限","已成交","竞价中","已上架","未上架"
                    ])
            ])
        Observable.of(deleteCommand , itemCommand)
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
    
    // 状态下拉视图
    private lazy var statusView:DropViewContainer = {
       let statusView = GoodsSupplyStatusDropView(tags: ["不限","已成交","竞价中","已上架","未上架"])
        return self.addDropView(drop: statusView, anchorView: self.dropAnchorView)
    }()
}

// 添加 下拉选项 操作
extension GoodsSupplyVC {
    
    func showStatusDropView() {
        if self.statusView.isShow == false {
            self.statusView.showDropViewAnimation()
        } else {
            self.statusView.hiddenDropView()
        }
    }
}


extension GoodsSupplyVC {
    // 获取DataSource
    static func getDataSource() -> RxTableViewSectionedAnimatedDataSource<MyHeaderSections> {
        let _dataSource = RxTableViewSectionedAnimatedDataSource<MyHeaderSections>(animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                                                                                                                         reloadAnimation: .fade,
                                                                                                                                                         deleteAnimation: .right)
            ,
                                                                                                          configureCell: {
                                                                                                            (dataSource, tv, indexPath, element) in
                                                                                                            let cell = tv.dequeueReusableCell(withIdentifier: goodsSupplyCellIdentity)! as! GoodsSupplyCell
                                                                                                            return cell
        },
                                                                                                          canEditRowAtIndexPath : { (datasource , indexpath) in
                                                                                                            return true
        })
        return _dataSource
    }
}

enum SupplyGoodsCommand {
    case TapItem(IndexPath)
    case ItemDelete(IndexPath)
//    case Refresh(items:[MyHeaderSections])
//    case LoadMore(moreItems:[String])
}

struct GoodsSupplyState {
    var sections:[MyHeaderSections]
    
    init(sections:[MyHeaderSections]) {
        self.sections = sections
    }
    
    func excute(command:SupplyGoodsCommand) -> GoodsSupplyState {
        switch command {
            case .TapItem( _):
                return self
            case .ItemDelete(let indexPath):
                var sections = self.sections
                var section = self.sections[indexPath.section]
                var items = section.items
                items.remove(at: indexPath.row)
                section.items = items
                sections[indexPath.section] = section
                return GoodsSupplyState(sections: sections)
        }
    }
    
}

struct MyHeaderSections  {
    var header:String
    var items:[String]
}

extension MyHeaderSections : AnimatableSectionModelType {
    var identity: String {
        return header
    }

    typealias Item = String

    init(original: MyHeaderSections, items: [Item]) {
        self = original
        self.items = items
    }
}
