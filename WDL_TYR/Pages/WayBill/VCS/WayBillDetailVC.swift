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

enum WayBillEvaluateStatus {
    case noEvaluate         // 未评价
    case myEvaluated        // 只有我评价
    case toMe               // 只有对我的评价
    case EvaluatedEachother // 已互评
}

class WayBillDetailVC: BaseVC {

    @IBOutlet weak var tableView: UITableView!
    
    public var wayBillInfo:WayBillInfoBean?
    
    private var pageInfo:WayBillInfoBean? = WayBillInfoBean()
    private var showBottom:Bool? = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pageInfo = self.wayBillInfo
        self.loadDetailInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func currentConfig() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0)
        self.tableView.separatorStyle = .singleLine
        self.tableView.separatorColor = UIColor(hex: "DDDDDD")
        self.tableView.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
    }
    
    func registerCells() {
        self.registerCell(nibName: "\(WayBillDetailStatusCell.self)", for: self.tableView)
        self.registerCell(nibName: "\(WayBillDealInfoCell.self)", for: self.tableView)
        self.registerCell(nibName: "\(WayBillGoodsCell.self)", for: self.tableView)
        self.registerCell(nibName: "\(WayBillTransLocationCell.self)", for: self.tableView)
        self.registerCell(nibName: "\(WayBillOneCommentCell.self)", for: self.tableView)
        self.registerCell(nibName: "\(WayBillCommentAllCell.self)", for: self.tableView)
        self.registerCell(nibName: "\(WayBillReceiptCell.self)", for: self.tableView)
    }
}

extension WayBillDetailVC {
    
    // 根据 对应的状态 ， 展示不同的cells
    func tableViewCells(tableView:UITableView , indexPath:IndexPath) -> UITableViewCell {
        switch (self.wayBillInfo?.transportStatus)! {
        case .willToTransport , .noStart:
            return self.willToTransportTableViewCell(tableView:tableView, indexPath:indexPath)
        case .transporting:
            return self.transportingCells(indexPath: indexPath, tableView: tableView)
        case .willToPickup , .driverPickup:
            return self.willToPickCells(indexPath: indexPath, tableView: tableView)
        case .done:
            return self.pickupAndCommentCells(indexPath: indexPath, tableView: tableView)
        default:
            return self.willToTransportTableViewCell(tableView:tableView, indexPath:indexPath)
        }
    }
    
    // 待起运的状态下的 cells
    func willToTransportTableViewCell(tableView:UITableView ,indexPath:IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDetailStatusCell.self)") as! WayBillDetailStatusCell
                cell.showInfo(status: (self.pageInfo?.transportStatus)!)
                return cell
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDealInfoCell.self)") as! WayBillDealInfoCell
            self.showInfoForDealCell(cell: cell)
            return cell
        }
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillGoodsCell.self)") as! WayBillGoodsCell
            cell.contentInfo(info: self.pageInfo)
            return cell
        }
        
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
    // 运输中的 cells
    func transportingCells(indexPath:IndexPath , tableView:UITableView) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDetailStatusCell.self)") as! WayBillDetailStatusCell
                cell.showInfo(status: (self.pageInfo?.transportStatus)!)
                return cell
            }
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillTransLocationCell.self)") as! WayBillTransLocationCell
                cell.showLocation(locations: self.pageInfo?.locationList ?? [])
                return cell
            }
            //回执单
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillReceiptCell.self)") as! WayBillReceiptCell
            cell.showReceiptInfo(info: self.pageInfo?.returnList ?? [])
            return cell
        }
        // 成交信息
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDealInfoCell.self)") as! WayBillDealInfoCell
            self.showInfoForDealCell(cell: cell)
            return cell
        }
        // 货源信息
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillGoodsCell.self)") as! WayBillGoodsCell
            cell.contentInfo(info: self.pageInfo)
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
    // 待签收 的 cells
    func willToPickCells(indexPath:IndexPath , tableView:UITableView) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDetailStatusCell.self)") as! WayBillDetailStatusCell
                cell.showInfo(status: (self.pageInfo?.transportStatus)!)
                return cell
            }
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillTransLocationCell.self)") as! WayBillTransLocationCell
                cell.showLocation(locations: self.pageInfo?.locationList ?? [])
                return cell
            }
            //回执单
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillReceiptCell.self)") as! WayBillReceiptCell
            cell.showReceiptInfo(info: self.pageInfo?.returnList ?? [])
            return cell
        }
        // 成交信息
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDealInfoCell.self)") as! WayBillDealInfoCell
            self.showInfoForDealCell(cell: cell)
            return cell
        }
        // 货源信息
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillGoodsCell.self)") as! WayBillGoodsCell
            cell.contentInfo(info: self.pageInfo)
            return cell
        }
        return UITableViewCell(style: .default, reuseIdentifier: "cell")
    }
    
    // 已签收
    func pickupAndCommentCells(indexPath:IndexPath , tableView:UITableView) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDetailStatusCell.self)") as! WayBillDetailStatusCell
                cell.showInfo(status: (self.pageInfo?.transportStatus)!)
                return cell
            }
            if indexPath.row == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillTransLocationCell.self)") as! WayBillTransLocationCell
                cell.showLocation(locations: self.pageInfo?.locationList ?? [])
                return cell
            }
            //回执单
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillReceiptCell.self)") as! WayBillReceiptCell
            cell.showReceiptInfo(info: self.pageInfo?.returnList ?? [])
            return cell
        }
        // 成交信息
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillDealInfoCell.self)") as! WayBillDealInfoCell
            self.showInfoForDealCell(cell: cell)
            return cell
        }
        // 货源信息
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillGoodsCell.self)") as! WayBillGoodsCell
            cell.contentInfo(info: self.pageInfo)
            return cell
        }
        // 有评价信息的展示
        let wayBillStatus = self.currrentEvaluatedStatus()
        switch wayBillStatus {
        case .noEvaluate: // 未评价
            return UITableViewCell(style: .default, reuseIdentifier: "cell")
        case .EvaluatedEachother: // 已互评
            return self.commentForEachOther(tableView: tableView)
        case .myEvaluated:  // 我已评价
            return commentForThird(tableView: tableView)
        case .toMe:      // 已评价我
            return self.commentInfoToMe(tableView: tableView)
        }
    }
    
    // 已签收，我已评价，对方未评价
    func commentForThird(tableView:UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillOneCommentCell.self)") as! WayBillOneCommentCell
        let myComment = self.myComment(evaluteList: self.pageInfo?.evaluateList)
        let commentInfo = WayBillDetailCommentInfo(rate: myComment?.evaluateScore, comment: nil, commentTime: myComment?.endTime)
        cell.showComment(info: commentInfo)
        return cell
    }
    
    // 已签收，我未评价，对方已评价
    func commentInfoToMe(tableView:UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillOneCommentCell.self)") as! WayBillOneCommentCell
        let commentMe = self.myComment(evaluteList: self.pageInfo?.evaluateList)
        let commentInfo = WayBillDetailCommentInfo(rate: commentMe?.evaluateScore, comment: nil, commentTime: commentMe?.endTime)
        cell.showComment(info: commentInfo)
        return cell
    }
    
    // 已签收，双方互评
    func commentForEachOther(tableView:UITableView) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(WayBillCommentAllCell.self)") as! WayBillCommentAllCell
        let commentMe = self.myComment(evaluteList: self.pageInfo?.evaluateList)
        let commentMeInfo = WayBillDetailCommentInfo(rate: commentMe?.evaluateScore, comment: nil, commentTime: commentMe?.endTime)
        let myComment = self.myComment(evaluteList: self.pageInfo?.evaluateList)
        let myCommentInfo = WayBillDetailCommentInfo(rate: myComment?.evaluateScore, comment: nil, commentTime: myComment?.endTime)
        cell.showCommentInfo(toMeinfo: commentMeInfo, myCommentInfo: myCommentInfo)
        return cell
    }
    
    // 为cell 添加 成交信息
    func showInfoForDealCell(cell:WayBillDealInfoCell) -> Void {
        let unit = self.pageInfo?.dealUnitPrice
        let amount = self.pageInfo?.dealTotalPrice
        let cyName = self.pageInfo?.carrierName
        let driver = self.pageInfo?.dirverName
        let truckInfo = Util.concatSeperateStr(seperete: " | ", strs: self.pageInfo?.vehicleLength , self.pageInfo?.vehicleWidth , self.pageInfo?.vehicleType , self.pageInfo?.vehicleNo)
        let dealTime = self.pageInfo?.dealTime
        
        cell.showDealInfo(unit: unit,
                          amount: amount,
                          cyName: cyName,
                          driver: driver,
                          truckInfo: truckInfo,
                          dealTime: dealTime)
    }
}


//DataSource
extension WayBillDetailVC : UITableViewDelegate , UITableViewDataSource {
    
    //运单状态 1=待起运 2=运输中 3=待签收 4=已签收  5=被拒绝
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.pageInfo?.transportStatus == WayBillTransportStatus.willToTransport
        || self.pageInfo?.transportStatus == WayBillTransportStatus.noStart{ // 待起运
            return 2
        }
        if self.pageInfo?.transportStatus == WayBillTransportStatus.transporting { // 运输中
            return 3
        }
        if self.pageInfo?.transportStatus == WayBillTransportStatus.done { // 已签收
            let wayBillStatus = self.currrentEvaluatedStatus()
            switch wayBillStatus {
            case .noEvaluate:
                return 3
            case .EvaluatedEachother:
                return 4
            case .myEvaluated:
                return 4
            case .toMe:
                return 4
            }
        }
        if self.pageInfo?.transportStatus == WayBillTransportStatus.willToPickup || self.pageInfo?.transportStatus == .driverPickup { // 待签收
            return 3
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.pageInfo?.transportStatus == WayBillTransportStatus.willToTransport || self.pageInfo?.transportStatus == WayBillTransportStatus.noStart { // 待起运
            if section == 0 {
                return 2
            }
            return 1
        }
        if self.pageInfo?.transportStatus == WayBillTransportStatus.transporting { // 运输中
            if section == 0 {
                return 3
            }
            return 1
        }
        if self.pageInfo?.transportStatus == WayBillTransportStatus.done { // 已签收
            if section == 0 {
                return 3
            }
            return 1
        }
        if self.pageInfo?.transportStatus == WayBillTransportStatus.willToPickup || self.pageInfo?.transportStatus == .driverPickup { // 待签收
            if section == 0 {
                return 3
            }
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.tableViewCells(tableView: tableView, indexPath: indexPath)
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.01
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
    }
}

extension WayBillDetailVC {
    
    // 取消运单
    func cancelWayBill() -> Void {
        AlertManager.showTitleAndContentAlert(title: "提示", content: "确认取消运单？") { [weak self](index) in
            if index == 1 {
                self?.showLoading(title: "", complete: nil)
                BaseApi.request(target: API.transportTransaction(self?.pageInfo?.transportNo ?? ""), type: BaseResponseModel<String>.self)
                    .subscribe(onNext: { (data) in
                        self?.showSuccess()
                        self?.loadDetailInfo()
                    }, onError: { (error) in
                        self?.showFail(fail: error.localizedDescription, complete: nil)
                    })
                    .disposed(by: self?.dispose ?? DisposeBag())
            }
        }
    }
    
    // 确认起运
    func sureToTransport() -> Void {
        AlertManager.showTitleAndContentAlert(title: "确认起运", content: "确认起运？") { (index) in
            if index == 1 {
                self.showLoading(title: "", complete: nil)
                BaseApi.request(target: API.transportTransaction(self.pageInfo?.transportNo ?? ""), type: BaseResponseModel<String>.self)
                    .subscribe(onNext: { (data) in
                        self.showSuccess()
                        self.loadDetailInfo()
                    }, onError: { (error) in
                        self.showFail(fail: error.localizedDescription, complete: nil)
                    })
                    .disposed(by: self.dispose)
            }
        }
    }
    
    // 确认签收
    func toPickWayBill() -> Void {
        AlertManager.showTitleAndContentAlert(title: "确认签收", content: "确认签收？") { (index) in
            if index == 1 {
                self.showLoading(title: "", complete: nil)
                BaseApi.request(target: API.transportSign(self.pageInfo?.transportNo ?? ""), type: BaseResponseModel<String>.self)
                    .subscribe(onNext: { (data) in
                        self.showSuccess()
                        self.loadDetailInfo()
                    }, onError: { (error) in
                        self.showFail(fail: error.localizedDescription, complete: nil)
                    })
                    .disposed(by: self.dispose)
            }
        }
    }
    
    // 获取运单详情
    func loadDetailInfo() -> Void {
        self.showLoading()
        BaseApi.request(target: API.sinGletransaction(self.wayBillInfo?.id ?? ""), type: BaseResponseModel<WayBillInfoBean>.self)
            .subscribe(onNext: { (data) in
                self.showSuccess()
                self.pageInfo = data.data
                self.tableView.reloadData()
                self.addBottom()
            }, onError: { (error) in
                self.showFail(fail: error.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
    }
    
    func addBottom() {
        self.showBottom = false
        switch self.pageInfo?.transportStatus ?? .noStart {
        case .noStart,.willToTransport:
            self.bottomButtom(titles: ["取消运单" ,"确认起运"], targetView: self.tableView) { [weak self](index) in
                if index == 0 {
                    self?.cancelWayBill() // 取消起运
                }else {
                    self?.sureToTransport() // 确认起运
                }
            }
            self.showBottom = true
            break
        case .transporting:
            self.bottomButtom(titles: ["确认签收"], targetView: self.tableView) { [weak self](_) in
                self?.toPickWayBill()
            }
            self.showBottom = true
            break;
        case .willToPickup , .driverPickup:
            self.bottomButtom(titles: ["确认签收"], targetView: self.tableView) {[weak self] (_) in
                self?.toPickWayBill()
            }
            self.showBottom = true
            break;
        case .done:
            self.bottomButtom(titles: ["评价此单"], targetView: self.tableView) { [weak self](_) in
                self?.toCommentWayBill()
            }
            break
        default:
            self.bottomButtom(titles: [], targetView: self.tableView)
        }
        self.tableViewFooterHeightChange()
    }
    
    func tableViewFooterHeightChange() -> Void {
        if self.showBottom == false {
            self.tableView.tableFooterView = UIView()
            return
        }
        self.tableView.tableFooterView = {
            let view = UIView(frame: CGRect(origin: .zero, size: CGSize(width: IPHONE_WIDTH, height: 60)))
            view.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
            return view
        }()
    }
    
    //MARK: - Evaluated
    // 签收状态下，根据 返回的数据 ， 判断当前的评价状态
    func currrentEvaluatedStatus() -> WayBillEvaluateStatus {
        if self.pageInfo?.evaluateList == nil || self.pageInfo?.evaluateList?.count == 0 {
            return .noEvaluate
        }
        let evaluatedList = self.pageInfo?.evaluateList
        let myComment = self.myComment(evaluteList: evaluatedList)
        let commetMe = self.commentToMe(evaluteList: evaluatedList)
        if myComment != nil && commetMe != nil { // 互评
            return .EvaluatedEachother
        }
        if myComment != nil && commetMe == nil { // 我已评价
            return .myEvaluated
        }
        
        if myComment == nil && commetMe != nil {
            return .toMe
        }
        
        return .noEvaluate
    }
    
    // 获取我评价别人
    func myComment(evaluteList:[ZbnEvaluate]?) -> ZbnEvaluate? {
        var evaluted:ZbnEvaluate? = nil
        if let evaluteList = evaluteList {
            let filterEvaluate = evaluteList.filter { (value) -> Bool in
                return value.evaluateTo == 1 || value.evaluateTo == 2
            }
            if filterEvaluate.count > 0 {
                evaluted = filterEvaluate.first
            }
        }
        return evaluted
    }
    
    // 获取评价我的
    func commentToMe(evaluteList : [ZbnEvaluate]?) -> ZbnEvaluate? {
        var evaluted:ZbnEvaluate? = nil
        if let evaluteList = evaluteList {
            let filterEvaluate = evaluteList.filter { (value) -> Bool in
                return value.evaluateTo == 3 || value.evaluateTo == 4
            }
            if filterEvaluate.count > 0 {
                evaluted = filterEvaluate.first
            }
        }
        return evaluted
    }
    
    // 获取当前的
}
