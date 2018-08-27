//
//  DropViewManage.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/25.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation


class DropViewManager {
    
    static func showGoodsSupplyStatus(frame:CGRect,
                                      targetView:UIView ,
                                      tapItemClosure:((Int) -> ()))  -> GoodsSupplyStatusDropView {
        let statusDropView = GoodsSupplyStatusDropView(frame: frame, titles: ["不限","已成交","竞价中","已上架","未上架"] , targetView:targetView)
        return statusDropView
    }
}
