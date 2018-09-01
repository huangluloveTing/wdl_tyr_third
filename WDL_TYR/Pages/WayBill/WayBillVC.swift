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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wr_setNavBarShadowImageHidden(true)
        self.addNaviHeader()
        self.addMessageRihgtItem()
        self.emptyTitle(title: "暂无运单", to: self.tableView)
        self.hiddenTableViewSeperate(tableView: self.tableView)
        self.handle()
    }
    
    override func currentConfig() {
        self.registerCells()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func bindViewModel() {
        self.tableView.rx.willDisplayCell
            .subscribe(onNext:{(cell , indexPath) in
                cell.contentView.shadowBorder(radius: 4, bgColor: UIColor.white , insets:UIEdgeInsetsMake(20, 15, 0, 15))
            })
            .disposed(by: dispose)
        
        self.tableView.rx.itemSelected.asObservable()
            .subscribe(onNext: { (indexPath) in
                self.toWayBillDetail()
            })
            .disposed(by: dispose)
        
    }
    
    func registerCells() {
        self.registerCell(nibName: "\(WayBillCell.self)", for: self.tableView)
    }
}

// observable
extension WayBillVC {
    
    func handle() {
        let initial = SectionModel<String , String>(model: "", items: ["123" , "234","23","534543"])
        Observable.of([initial])
            .bind(to: self.tableView.rx.items(dataSource: self.instanceDataSource()))
            .disposed(by: dispose)
    }
    
}


// DataSource
extension WayBillVC {
    func instanceDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String, String>> {
        let datasource = RxTableViewSectionedReloadDataSource<SectionModel<String ,String>>(
            configureCell: {(dataSource , ts , indexPath , item) -> UITableViewCell in
            let cell = ts.dequeueReusableCell(withIdentifier: "\(WayBillCell.self)")
            return cell!
            })
        return datasource
    }
}




