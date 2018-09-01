//
//  WayBillDetailVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/1.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxDataSources
import RxSwift
import RxCocoa

class WayBillDetailVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func currentConfig() {
        Observable.of([SectionModel<String , String>(model: "header", items: ["12323" , "sfsf"])])
            .bind(to: self.tableView.rx.items(dataSource: self.detailDataSource()))
            .disposed(by: dispose)
    }
    
    func registerCells() {
        self.registerCell(nibName: "\(WayBillDetailStatusCell.self)", for: self.tableView)
    }
}


//DataSource
extension WayBillDetailVC {
    
    func detailDataSource() -> RxTableViewSectionedReloadDataSource<SectionModel<String , String>> {
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String , String>>(configureCell: {(dataSource , ts , indexPath , element) -> UITableViewCell in
                let cell = ts.dequeueReusableCell(withIdentifier: "\(WayBillDetailStatusCell.self)")
            return cell!
            })
        return dataSource
    }
    
}
