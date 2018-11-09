//
//  MessageCenterVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/3.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class MessageCenterVC: NormalBaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let titles = ["报价信息","运单信息","系统信息"]
    private let icons = [UIImage.init(named: "message_offer")!,UIImage.init(named: "message_yd")!,UIImage.init(named: "message_alert")!]

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
}

//MARK: - config
extension MessageCenterVC {
    func configTableView() -> Void {
        tableView.delegate = self
        tableView.dataSource = self
        self.registerCell(nibName: "\(MessageCenterCell.self)", for: tableView)
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
    }
}

//MARK: - UITableViewDelegate , UITableViewDataSource
extension MessageCenterVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(MessageCenterCell.self)") as! MessageCenterCell
        cell.showInfo(icon: icons[indexPath.row], title: titles[indexPath.row], content: nil)
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

//MARK: - Handles
extension MessageCenterVC {
    
    // 去报价信息
    func toOfferMessages() -> Void {
        
    }
    
    // 去运单信息
    func wayBillsMessages() -> Void {
        
    }
    
    // 去系统信息
    func systermMessages() -> Void {
        
    }
}
