//
//  GoodsSupplyVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/24.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift

let goodsSupplyCellIdentity = "\(GoodsSupplyCell.self)"

class GoodsSupplyVC: MainBaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statusButton: MyButton!
    @IBOutlet weak var dropAnchorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wr_setNavBarShadowImageHidden(true)
        self.addNaviHeader()
        self.addMessageRihgtItem()
        self.toConfigDataSource()
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
        // Dispose of any resources that can be recreated.
    }
    
    
    override func bindViewModel() {
        self.statusButton.rx.tap
            .subscribe(onNext: { () in
                self.showStatusDropView()
            })
            .disposed(by: dispose)
    }
    
    // 状态下拉视图
    private lazy var statusView:DropViewContainer = {
       let statusView = GoodsSupplyStatusDropView(tags: ["不限","已成交","竞价中","已上架","未上架"])
        return self.addDropView(drop: statusView, anchorView: self.dropAnchorView)
    }()
}



extension GoodsSupplyVC {
    
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

//TODO: 模拟数据
extension GoodsSupplyVC {
    func toConfigDataSource() {
        let items = Observable.just([
                AnimatableSectionModel(model: "", items: [
                    "1","2","3","1","2","3","1","2","3","1","2","3"
                ])
            ])
        
        let dataSource = RxTableViewSectionedAnimatedDataSource<AnimatableSectionModel<String , String>>(animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                                                                                                              reloadAnimation: .fade,
                                                                                                                                              deleteAnimation: .left)
            ,configureCell: {
            (dataSource, tv, indexPath, element) in
                let cell = tv.dequeueReusableCell(withIdentifier: goodsSupplyCellIdentity)! as! GoodsSupplyCell
                return cell
        })
        
        dataSource.canEditRowAtIndexPath = { (datasource , indexpath) in
            return true
        }
        
        tableView.rx.willDisplayCell
            .subscribe(onNext:{ (tc , index) in
                let cell = tc as! GoodsSupplyCell
                cell.containerView.shadowBorder(radius: 5 , bgColor: UIColor.white, width:IPHONE_WIDTH - 40)
            })
            .disposed(by: dispose)
        
        tableView.rx.itemDeleted.asObservable()
            .subscribe(onNext: { (index) in
                
            })
            .disposed(by: dispose)
        
        items.bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: dispose)
    }
}
