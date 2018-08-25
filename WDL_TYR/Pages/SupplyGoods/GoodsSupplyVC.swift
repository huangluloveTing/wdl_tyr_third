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
    
    private lazy var statusView:GoodsSupplyStatusDropView = {
        self.statusView = DropViewManager.showGoodsSupplyStatus(frame: CGRect(origin: CGPoint(x: 0, y: 45), size: CGSize(width: self.view.zt_width , height: self.view.zt_height - 45)), targetView: self.view) { (index) in
            
        }
        
        return self.statusView
    }()
}


// 添加 下拉操作
extension GoodsSupplyVC {
    
    func showStatusDropView() {
        
        if self.statusView.isShow == false {
            self.statusView.animationShow()
        } else {
            self.statusView.animationHidden()
        }
    }
}
