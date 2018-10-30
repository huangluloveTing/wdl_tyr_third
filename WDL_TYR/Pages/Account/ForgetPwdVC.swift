//
//  ForgetPwdVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxCocoa

class ForgetPwdVC: NormalBaseVC {

    @IBOutlet weak var saveButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func currentConfig() {
        self.saveButton.addBorder(color: nil)
    }

    override func bindViewModel() {
        self.saveButton.rx.tap.asObservable()
            .subscribe(onNext: { () in
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: dispose)
    }
    
   

}
