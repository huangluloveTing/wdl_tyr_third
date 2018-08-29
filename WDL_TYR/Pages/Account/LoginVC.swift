//
//  WDLLoginVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginVC: BaseVC {
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var passworldTextField: UITextField!
    
    
    //MARK: config
    override func currentConfig() {
        self.fd_prefersNavigationBarHidden = true
        self.loginButton.addBorder(color: nil)
        self.registerButton.addBorder(color: UIColor(hex: COLOR_BORDER), width: 1)
    }
    
    override func bindViewModel() {
        self.registerButton.rx.tap
            .subscribe(onNext: {[weak self] in
                self?.toRegisterVC(title: nil)
            })
            .disposed(by: dispose) 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //忘记密码
    @IBAction func forgetPwdAction(_ sender: Any) {
        self.toForgetPwdVC()
    }

    // 点击我是承运人
    @IBAction func toCYRAction(_ sender: Any) {
        self.toMainVC()
    }
    
    // 点击联系客服
    @IBAction func toLinkCustomerServiceAction(_ sender: Any) {
        self.toLinkKF()
    }
}
