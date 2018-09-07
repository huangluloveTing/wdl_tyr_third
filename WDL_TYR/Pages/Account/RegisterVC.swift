//
//  RegisterVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RegisterVC: BaseVC {
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var verifyButton: UIButton!
    
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var verifyTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    
    var registerInfo = RegisterVModel()
    
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
    
    override func bindViewModel() {
        self.phoneTextField.rx.text.orEmpty
            .subscribe(onNext: { (text) in
                self.registerInfo.phone = text
            })
            .disposed(by: dispose)
        
        self.verifyTextField.rx.text.orEmpty
            .subscribe(onNext: { (text) in
                self.registerInfo.veryCode = text
            })
            .disposed(by: dispose)
        
        self.passwordTextField.rx.text.orEmpty
            .subscribe(onNext: { (text) in
                self.registerInfo.pwd = text
            })
            .disposed(by: dispose)
        
        self.confirmTextField.rx.text.orEmpty
            .subscribe(onNext: { (text) in
                self.registerInfo.confirmPwd = text
            })
            .disposed(by: dispose)
        
        self.registerButton.rx.tap.asObservable()
            .map({ (handle) -> () in
                return handle
            })
            .subscribe(onNext: { () in
                
            })
            .disposed(by: dispose)
    }

    //MARK: actions
    @IBAction func toProtocol(_ sender: Any) { // 跳转织布鸟注册协议
        RegisterAgreeView.showRegisterAgreementView()
    }
    @IBAction func readProtocolAction(_ sender: UIButton) { // 点击已读协议
        sender.isSelected = !sender.isSelected
        self.registerInfo.readedProtocol = sender.isSelected
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



class RegisterVModel: NSObject {
    
    let disponse = DisposeBag()
    
    var phone:String?
    var veryCode:String?
    var pwd:String?
    var confirmPwd:String?
    var readedProtocol:Bool? // 是否阅读协议
}
