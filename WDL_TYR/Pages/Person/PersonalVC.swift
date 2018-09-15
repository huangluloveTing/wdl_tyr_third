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

let personImgs:[UIImage] = [#imageLiteral(resourceName: "认证") , #imageLiteral(resourceName: "消息中心"), #imageLiteral(resourceName: "个人设置") , #imageLiteral(resourceName: "联系客服")]
let personTitles:[String] = ["我的认证","消息中心","个人设置","联系客服"]

class PersonalVC: MainBaseVC  {
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var dropHintView: DropHintView!
    
    private var personInfos:[PersonExcuteInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fd_prefersNavigationBarHidden = true
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
        self.initialPersonExcuteInfos()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
        self.tableView.separatorStyle = .none
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
extension PersonalVC :  UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return self.personInfos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(PersonalInfoHeader.self)") as! PersonalInfoHeader
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(PersonalExcuteCell.self)") as! PersonalExcuteCell
        
        cell.contentInfo(info: self.personInfos![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 10
        }
        return 0.01
    }
    
    func initialPersonExcuteInfos() -> Void {
        self.personInfos = []
        for index in 0..<4 {
            var info = PersonExcuteInfo()
            info.image = personImgs[index]
            info.exTitle = personTitles[index]
            info.showIndicator = true
            if index == 3 {
                info.showIndicator = false
            }
            self.personInfos?.append(info)
        }
    }
    
}
