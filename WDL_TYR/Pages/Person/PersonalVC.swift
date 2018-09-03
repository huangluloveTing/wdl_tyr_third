//
//  PersonalVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/24.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class PersonalVC: MainBaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dropHintView: DropHintView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.dropHintView.dataSource = self
//        self.dropHintView.tabTitles(titles: ["消息时间","全部"])
//        self.dropHintView.dropTapClosure = {(index) in
//            print("current tap index ： \(index)")
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
//    func dropHintView(dropHint: DropHintView, index: Int) -> UIView {
//        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.zt_width, height: 100))
//        if index == 0 {
//            view.backgroundColor = UIColor.red
//            
//        } else {
//            view.backgroundColor = UIColor.blue
//        }
//        return view
//    }
    
    override func currentConfig() {
        self.registerCell(nibName: "\(PersonalInfoHeader.self)", for: self.tableView)
        self.registerCell(nibName: "\(PersonalExcuteCell.self)", for: self.tableView)
    }
    
    override func bindViewModel() {
        self.tableView.rx.itemSelected.asObservable()
            .subscribe(onNext: { (indexPath) in
                
            })
            .disposed(by: dispose)
    }
}

// datasource
extension PersonalVC {
    
}
