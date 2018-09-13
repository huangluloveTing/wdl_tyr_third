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

let dueTime = 10

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
        self.view.backgroundColor = UIColor.white
        self.fd_interactivePopDisabled = true
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
                self.toRegisterAccount()
            })
            .disposed(by: dispose)
        
        self.verifyButton.rx.tap
            .subscribe(onNext:{
                if isPhone(phone: self.registerInfo.phone) {
                    self.obtainVeryCode(phone: self.registerInfo.phone!)
                }
                else {
                    self.showWarn(warn: "请输入正确的手机号码")
                }
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
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func toLinkCustomerSerAction(_ sender: Any) { // 联系客服
        self.toLinkKF()
    }
    
    
}

extension RegisterVC {
    
    func toRegisterAccount() {
        if !isPhone(phone: self.registerInfo.phone) {
            self.showWarn(warn: "手机号码不正确")
            return
        }
        if self.registerInfo.veryCode?.count == 0 {
            self.showWarn(warn: "请填写验证码")
            return
        }
        if !isCorrectPwd(pwd: self.registerInfo.pwd)  {
            self.showWarn(warn: "请填写正确的密码")
            return
        }
        if self.registerInfo.confirmPwd != self.registerInfo.pwd {
            self.showWarn(warn: "确认密码与第一次输入的密码不一致")
            return
        }
        if self.registerInfo.readedProtocol == false || self.registerInfo.readedProtocol == nil {
            self.showWarn(warn: "请阅读织布鸟注册协议", complete: nil)
            return
        }
        
        self.showLoading(title: "正在提交", complete: nil)
        BaseApi.request(target: API.register(self.registerInfo.pwd!, self.registerInfo.phone!, self.registerInfo.veryCode!, self.registerInfo.confirmPwd!), type: BaseResponseModel<AnyObject>.self)
            .subscribe(onNext: { (model) in
                self.showSuccess(success: "注册成功", complete: {[weak self] in
                    self?.pop()
                })
            }, onError: { (error) in
                self.showFail(fail: error.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
    }
    
    func obtainVeryCode(phone:String) {
        self.showLoading()
        self.verifyButton.isEnabled = false
        BaseApi.request(target: API.registerSms(phone), type: BaseResponseModel<Any>.self)
            .subscribe(onNext: { (model) in
                self.showSuccess(success: "获取验证码成功", complete: nil)
                self.timedownVeryCodeButton()
            },
                       onError: { (eror) in
                self.verifyButton.isEnabled = true
                self.showFail(fail: eror.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
    }
    
    func timedownVeryCodeButton()  {
        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .take(RxTimeInterval(dueTime), scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (time) in
                self?.verifyButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                self?.verifyButton.setTitle(String(format: "%ds", time), for: UIControlState.normal)
            }, onCompleted: { [weak self] in
                self?.verifyButton.isEnabled = true
                self?.verifyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                self?.verifyButton.setTitle("重新获取", for: UIControlState.normal)
            })
            .disposed(by: dispose)
    }
}



class RegisterVModel: NSObject {
    var phone:String?
    var veryCode:String?
    var pwd:String?
    var confirmPwd:String?
    var readedProtocol:Bool? // 是否阅读协议
}
