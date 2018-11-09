//
//  ForgetPwdVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class ForgetPwdVC: NormalBaseVC {
    //保存修改
    @IBOutlet weak var saveButton: UIButton!
    //手机输入框
    @IBOutlet weak var phoneField: UITextField!
    //验证码输入框
    @IBOutlet weak var codeField: UITextField!
    //发送验证码按钮
    @IBOutlet weak var sendCodeButton: UIButton!
    //新密码输入框
    @IBOutlet weak var newPsdField: UITextField!
    //确认密码输入框
    @IBOutlet weak var surePsdField: UITextField!
    
    //上传的model
    var ForgetInfo = ForgetPasswordModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    //页面配置
    override func currentConfig() {
        self.saveButton.addBorder(color: nil)
    }
    // 绑定vm
    override func bindViewModel() {
        //判断是否合法
        self.phoneField.rx.text.orEmpty
            .subscribe(onNext: { (text) in
                self.ForgetInfo.phone = text
            })
            .disposed(by: dispose)
        
        self.codeField.rx.text.orEmpty
            .subscribe(onNext: { (text) in
                self.ForgetInfo.verificationCode = text
            })
            .disposed(by: dispose)
        
        self.newPsdField.rx.text.orEmpty
            .subscribe(onNext: { (text) in
                self.ForgetInfo.password = text
            })
            .disposed(by: dispose)
        
        self.surePsdField.rx.text.orEmpty
            .subscribe(onNext: { (text) in
                self.ForgetInfo.verificationPassword = text
            })
            .disposed(by: dispose)
        //发送验证码按钮
        self.sendCodeButton.rx.tap.subscribe(onNext:{
            if isPhone(phone: self.ForgetInfo.phone){
                //验证码请求
                self.obtainVeryCode(phone: self.ForgetInfo.phone)
            }else {
                self.showWarn(warn: "请输入正确的手机号码")
            }
        })
        .disposed(by: dispose)
        
        //保存修改按钮
        self.saveButton.rx.tap.asObservable()
            .subscribe(onNext: { () in
                self.toSaveButtonRequest()
            })
            .disposed(by: dispose)
    }
    
   

}


extension ForgetPwdVC {
    
    
    //判断所有条件是否合法
    func toSaveButtonRequest() {
        if self.ForgetInfo.phone.count == 0 {
            self.showWarn(warn: "请填写手机号")
            return
        }
        if !isPhone(phone: self.ForgetInfo.phone) {
            self.showWarn(warn: "手机号码不正确")
            return
        }
        if self.ForgetInfo.verificationCode.count == 0 {
            self.showWarn(warn: "请填写验证码")
            return
        }
        
        if self.ForgetInfo.password.count == 0 {
            self.showWarn(warn: "请填写新密码")
            return
        }
        if self.ForgetInfo.verificationPassword.count == 0 {
            self.showWarn(warn: "请填写确认密码")
            return
        }
        if !isCorrectPwd(pwd: self.ForgetInfo.password)  {
            self.showWarn(warn: "请填写正确的密码")
            return
        }
        if self.ForgetInfo.password != self.ForgetInfo.verificationPassword {
            self.showWarn(warn: "确认密码与第一次输入的密码不一致")
            return
        }
    
        self.showLoading(title: "正在提交", complete: nil)
        BaseApi.request(target: API.forgetPassword(self.ForgetInfo), type: BaseResponseModel<String>.self)
            .subscribe(onNext: { (model) in
                self.showSuccess(success: "修改成功", complete: {[weak self] in
                    self?.pop()
                })
            }, onError: { (error) in
                self.showFail(fail: error.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
   
    
    }
        
        
        
    
    //发送验证码请求
    func obtainVeryCode(phone:String) {
        self.showLoading()
        self.sendCodeButton.isEnabled = false
        BaseApi.request(target: API.registerSms(phone), type: BaseResponseModel<Any>.self)
            .subscribe(onNext: { (model) in
                self.showSuccess(success: "获取验证码成功", complete: nil)
                self.timedownVeryCodeButton()
            },
                       onError: { (eror) in
                        self.sendCodeButton.isEnabled = true
                        self.showFail(fail: eror.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
    }
    //验证码的动态时间
    func timedownVeryCodeButton()  {
        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .take(RxTimeInterval(dueTime), scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (time) in
                self?.sendCodeButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                self?.sendCodeButton.setTitle(String(format: "%ds", time), for: UIControlState.normal)
                }, onCompleted: { [weak self] in
                    self?.sendCodeButton.isEnabled = true
                    self?.sendCodeButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    self?.sendCodeButton.setTitle("重新获取", for: UIControlState.normal)
            })
            .disposed(by: dispose)
    }
}


