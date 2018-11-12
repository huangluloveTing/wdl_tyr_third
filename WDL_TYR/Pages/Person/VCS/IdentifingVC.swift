//
//  IdentifingVC.swift
//  WDL_TYR
//
//  Created by Apple on 2018/11/12.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit

class IdentifingVC: NormalBaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func callClick(_ sender: UIButton) {
        
        Util.toCallPhone(num: KF_PHONE_NUM)
    }
    

}
