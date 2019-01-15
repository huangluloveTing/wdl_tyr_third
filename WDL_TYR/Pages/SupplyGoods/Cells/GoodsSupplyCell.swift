//
//  GoodsSupplyCell.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/26.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class GoodsSupplyCell: BaseCell {
    //货源编号：id
     @IBOutlet weak var goodCodeId: UILabel!
    //底部视图
    @IBOutlet weak var containerView: UIView!
    //开始城市
    @IBOutlet weak var startLabel: UILabel!
    //结束城市
    @IBOutlet weak var endLabel: UILabel!
    //状态文本
    @IBOutlet weak var statusLabel: UILabel!
    //报价状态(暂无报价)
    @IBOutlet weak var reportLabel: UILabel!
    //多少人报价
    @IBOutlet weak var numLabel: UILabel!
//    //货品名称
//    @IBOutlet weak var goodsNameLabel: UILabel!
    //车辆货物描述
    @IBOutlet weak var goodsSpecLabel: UILabel!
    //车辆货物详情描述
    @IBOutlet weak var cartSpecLabel: UILabel!
    @IBOutlet weak var autoDealTagView: UIImageView!
    @IBOutlet weak var autoTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.containerView.backgroundColor = UIColor(hex: COLOR_BACKGROUND)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
//给cell赋值
extension GoodsSupplyCell {
    func showContent(item:GoodsSupplyListItem)  {
        self.configStatusLabel(status: item.isDeal ?? GoodsSupplyListStatus.status_soldout)
        let num = item.offer?.offerNumber ?? 0
        if num == 0 {
            self.numLabel.text = ""
            self.reportLabel.text = "暂无报价"
        }
        else {
            self.numLabel.text = String(num)
            self.reportLabel.text = "报价"
        }
        //货源编号
        self.goodCodeId.text = "货源编号：" + (item.id ?? "")
        //已成交和已下架,未上架不显示暂无报价
        if item.isDeal == GoodsSupplyListStatus.status_soldout{
            self.reportLabel.isHidden = true
        }
        if item.isDeal == GoodsSupplyListStatus.status_deal{
            self.reportLabel.isHidden = true
        }
        if item.isDeal == GoodsSupplyListStatus.status_bidding{
            self.reportLabel.isHidden = false
        }
        if item.isDeal == GoodsSupplyListStatus.status_putway{
            self.reportLabel.isHidden = true
        }

        self.startLabel.text = (item.startProvince ?? " ") + (item.startCity ?? " ")
        self.endLabel.text = (item.endProvince ?? " ") + (item.endCity ?? " ")
        //物料
//        self.goodsNameLabel.text = item.goodsName ?? " "
         //车辆货物描述
        self.goodsSpecLabel.text = self.getGoodsSpec(item: item)
        //车辆货物详情描述
        self.cartSpecLabel.text = self.getCartSpecText(item: item)
        
      //只要是未上架就需要显示
        if item.isDeal == .status_putway {
            self.autoDealTagView.isHidden = false
            self.autoTimeLabel.text = ("上架时间: " + Util.dateFormatter(date: (item.publishTime ?? 0) / 1000, formatter: "MM-dd HH:mm"))
            self.autoTimeLabel.isHidden = false
        } else {
            self.autoDealTagView.isHidden = true
            self.autoTimeLabel.text = " "
        }
        
    }
    
    func configStatusLabel(status:GoodsSupplyListStatus) {
        /**
         case InBidding // 竞标中
         case OffShelve // 已下架
         case InShelveOnTime // 定时上架
         case Deal       // 已成交
         */
        switch status {
        case .status_deal:
            self.statusLabel.text = "已成交"
            self.statusLabel.textColor = UIColor(hex: COLOR_BUTTON)
            break
        case .status_bidding:
            self.statusLabel.text = "竞价中"
            self.statusLabel.textColor = UIColor(hex: COLOR_BUTTON)
            break
        case .status_putway:
            self.statusLabel.text = "未上架"
            self.statusLabel.textColor = UIColor(hex: TEXTCOLOR_EMPTY)
            break
        default:
            
            let type = WDLCoreManager.shared().consignorType
            //第三方
            if type == .third {
               self.statusLabel.text = "已下架"
            }else{
                //经销商
              self.statusLabel.text = "未成交"
            }
            
            self.statusLabel.textColor = UIColor(hex: TEXTCOLOR_EMPTY)
            break
        }
    }
    //获物详情
    func getCartSpecText(item:GoodsSupplyListItem) -> String? {
        let weight = item.goodsWeight
        let length = item.vehicleLength
        let type = item.vehicleType
        let package = item.packageType
    
        let weightContent:String = (weight == nil) ? " " : (String(Float(weight!)) + "吨 | ")
        let lengthContent : String = (length == nil) ? " " : length! +  " | "
        let typeContent:String = (type == nil) ? " " : type! + " | "
        let packageContent : String = (package == nil) ? " " : package!
        return weightContent + lengthContent + typeContent + packageContent
        
    }
    
    func getGoodsSpec(item:GoodsSupplyListItem) -> String? {
        let time = item.loadingTime ?? Date().timeIntervalSince1970 * 1000
        let type = item.goodsType
        let timeStr = Util.dateFormatter(date: time / 1000, formatter: "MM-dd")
        return timeStr + " | " + (type ?? "")
    }
}
