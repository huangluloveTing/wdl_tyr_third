//
//  GoodsSupplyDetailVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/28.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class GoodsSupplyDetailVC: NormalBaseVC {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func moreAction(_ sender: Any) {
        if (self.textLabel.text?.count)! <= 5 {
            self.textLabel.text = "发哈佛half哈积分哈克龙发哈开机后付款啦话费卡后福利卡话费卡立方哈客户发联合发客服哈孔令辉发考虑好哈佛half哈积分哈克龙发哈开机后付款啦话费卡后福利卡话费卡立方哈客户发联合发客服哈孔令辉发考虑好哈佛half哈积分哈克龙发哈开机后付款啦话费卡后福利卡话费卡立方哈客户发联合发客服哈孔令辉发考虑好哈佛half哈积分哈克龙发哈开机后付款啦话费卡后福利卡话费卡立方哈客户发联合发客服哈孔令辉发考虑好"
        } else {
            self.textLabel.text = "fja"
        }
    }
    
}
