//
//  RegisterVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class RegisterVC: BaseVC {
    

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var verifyButton: UIButton!
    
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func currentConfig() {
        self.fd_prefersNavigationBarHidden = true
        self.registerButton.addBorder(color: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    //MARK: actions
    @IBAction func toProtocol(_ sender: Any) { // 跳转织布鸟注册协议
        RegisterAgreeView.showRegisterAgreementView()
    }
    @IBAction func readProtocolAction(_ sender: UIButton) { // 点击已读协议
        sender.isSelected = !sender.isSelected
    }
    @IBAction func toLoginAction(_ sender: Any) { // 去登录
        self.pop()
    }
    @IBAction func toTYRAction(_ sender: Any) { // 去我是承运人
    }
    @IBAction func toLinkCustomerSerAction(_ sender: Any) { // 联系客服
        self.toLinkKF()
    }
}

extension RegisterVC {
    
}
