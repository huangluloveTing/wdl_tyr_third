//
//  GoodsSupplyVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/24.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class GoodsSupplyVC: MainBaseVC {
    
    @IBOutlet weak var statusButton: MyButton!
    @IBOutlet weak var dropAnchorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wr_setNavBarShadowImageHidden(true)
        self.addNaviHeader()
        self.addMessageRihgtItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func bindViewModel() {
        self.statusButton.rx.tap
            .subscribe(onNext: { () in
                self.showStatusDropView()
            })
            .disposed(by: dispose)
    }
    
    private lazy var statusView:DropViewContainer = {
       let statusView = GoodsSupplyStatusDropView(tags: ["不限","已成交","竞价中","已上架","未上架"])
        return self.addDropView(drop: statusView, anchorView: self.dropAnchorView)
    }()
}


// 添加 下拉操作
extension GoodsSupplyVC {
    
    func showStatusDropView() {
        
        if self.statusView.isShow == false {
            self.statusView.showDropViewAnimation()
        } else {
            self.statusView.hiddenDropView()
        }
    }
}
