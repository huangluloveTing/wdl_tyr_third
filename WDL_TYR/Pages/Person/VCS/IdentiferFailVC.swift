//
//  IdentiferFailVC.swift
//  WDL_TYR
//
//  Created by Apple on 2018/11/12.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class IdentiferFailVC: NormalBaseVC {
    //失败原因
    @IBOutlet weak var failResonLable: UILabel!
    //重新提交按钮
    @IBOutlet weak var reSuButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        reSuButton.layer.cornerRadius = 4
        reSuButton.clipsToBounds = true
        self.failResonLable.text = "驳回原因：" + (WDLCoreManager.shared().userInfo?.authenticationMsg ?? "")
    }

    @IBAction func callClick(_ sender: UIButton) {
        
        Util.toCallPhone(num: KF_PHONE_NUM)
    }
    //重新提交
    @IBAction func reSummitClick(_ sender: UIButton) {
        
    }
}
