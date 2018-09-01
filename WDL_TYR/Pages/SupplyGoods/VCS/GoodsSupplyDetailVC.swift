//
//  GoodsSupplyDetailVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/28.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum GoodsSupplyStatus {
    case InBidding // 竞标中
    case OffShelve // 已下架
    case InShelveOnTime // 定时上架
    case Deal       // 已成交
}

class GoodsSupplyDetailVC: NormalBaseVC  {

    
    @IBOutlet weak var tableView: UITableView!
    
    private var currentSupplyStatus:GoodsSupplyStatus = .InBidding
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: lazy
    private lazy var bidingHeader:GSDetailBidingHeader = {
        return GoodsSupplyDetailVC.biddingHeaderInfoView()
    }() // 当为竞标中时，显示的header
    
    private var offShelveHeader:UIView?
    private var shelveTimerHeader:UIView?
    
    // config
    override func currentConfig() {
        self.view.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
        self.tableView.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
        self.toAddHeader()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        let footerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: IPHONE_WIDTH, height: 60)))
        footerView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = footerView
        self.registerAllCells()
        self.tableView.separatorStyle = .none
        self.bidingHeader.bidingTapClosure = { state in
            self.toAddHeader()
        }
    }
    
    override func bindViewModel() {
        self.tableView.rx.willDisplayCell
            .subscribe(onNext:{(cell ,index) in
                cell.contentView.shadowBorder(radius: 5,
                                              bgColor: UIColor.white,
                                            insets:UIEdgeInsetsMake(15, 15, 7.5, 15))
            })
            .disposed(by: dispose)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.bottomButtom(titles: ["取消" ,"确定"], targetView: self.tableView)
    }
}

// header
extension GoodsSupplyDetailVC {
    func toAddHeader() {
        if self.currentSupplyStatus == .InBidding {
            let headerHeight = self.bidingHeader.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
            self.bidingHeader.frame = CGRect(origin: .zero, size:CGSize(width: IPHONE_WIDTH, height:headerHeight))
            self.tableView.contentInset = UIEdgeInsetsMake(self.bidingHeader.zt_height, 0, 0, 0)
            self.view.addSubview(self.bidingHeader)
        } else {
            self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
            self.bidingHeader.removeFromSuperview()
        }
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
        self.registerCell(nibName: "\(GSDealedCell.self)", for: self.tableView)      // 已成交cell
        self.registerCell(nibName: "\(GSDetailInfoCell.self)", for: self.tableView)  // 货源详情
        self.registerCell(nibName: "\(GSTimerShelveCell.self)", for: self.tableView) // 按时上架cell
        self.registerCell(nibName: "\(GSOffShelveCell.self)", for: self.tableView)   // 竞价超时
        self.registerCell(nibName: "\(GSQutationCell.self)", for: self.tableView) // 竞价中时的cell
    }
}

extension GoodsSupplyDetailVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.currentSupplyStatus == .InBidding {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(GSQutationCell.self)")
            return cell!
        }
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = "113131"
        return cell
    }
}

extension GoodsSupplyDetailVC : UITableViewDelegate {
    
}
