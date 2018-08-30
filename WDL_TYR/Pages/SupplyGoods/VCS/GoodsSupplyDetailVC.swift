//
//  GoodsSupplyDetailVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/28.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

enum GoodsSupplyStatus {
    case InBidding // 竞标中
    case OffShelve // 已下架
    case InShelveOnTime // 定时上架
    case Deal       // 已成交
}

class GoodsSupplyDetailVC: NormalBaseVC  {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func currentConfig() {
        self.view.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
        self.toAddHeader(status: .InBidding)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let footerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: IPHONE_WIDTH, height: 60)))
        footerView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = footerView
        self.registerAllCells()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    @IBAction func moreAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    
    //MARK: lazy
    private lazy var bidingHeader:GSDetailBidingHeader = {
        return GoodsSupplyDetailVC.biddingHeaderInfoView()
    }()
    private var offShelveHeader:UIView?
    private var shelveTimerHeader:UIView?
}

// header
extension GoodsSupplyDetailVC {
    
    func toAddHeader(status:GoodsSupplyStatus) {
        self.bidingHeader.frame = CGRect(origin: .zero, size:CGSize(width: IPHONE_WIDTH, height:self.bidingHeader.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height))
        self.tableView.contentInset = UIEdgeInsetsMake(self.bidingHeader.zt_height, 0, 0, 0)
        self.view.addSubview(self.bidingHeader)
    }
}


// header view
extension GoodsSupplyDetailVC {
    
    // 当是竞标中的订单时 ，显示的头部竞标信息视图
    private static func biddingHeaderInfoView() -> GSDetailBidingHeader {
        let header = Bundle.main.loadNibNamed("\(GSDetailBidingHeader.self)", owner: nil, options: nil)?.first as! GSDetailBidingHeader
        header.foldHeader(isFolder: false)
        return header
    }
    
}

// cells
extension GoodsSupplyDetailVC {
    func registerAllCells() {
        self.registerCell(nibName: "\(GSDealedCell.self)")      // 已成交cell
        self.registerCell(nibName: "\(GSDetailInfoCell.self)")  // 货源详情
        self.registerCell(nibName: "\(GSTimerShelveCell.self)") // 按时上架cell
        self.registerCell(nibName: "\(GSOffShelveCell.self)")   // 竞价超时
    }
    
    func registerCell(nibName:String) {
        self.tableView.register(UINib(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
}

extension GoodsSupplyDetailVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "113131"
        return cell
    }
}

extension GoodsSupplyDetailVC : UITableViewDelegate {
    
}
