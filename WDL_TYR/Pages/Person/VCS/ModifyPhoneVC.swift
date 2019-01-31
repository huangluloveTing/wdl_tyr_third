//
//  ModifyPhoneVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/3.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ModifyPhoneVC: NormalBaseVC {
    
    //旧手机号码
    @IBOutlet weak var oldVerifyButton: UIButton!
    @IBOutlet weak var oldVerifyCodeTextField: UITextField!
    @IBOutlet weak var oldPhoneTextField: UITextField!
    
    //新手机号码
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var verifyCodeTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var commitButton: UIButton!
    
    private var modifyPhone = ModityPhoneModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func currentConfig() {
        self.phoneTextField.titleTextField(title: "新手机号码")
        self.verifyCodeTextField.titleTextField(title: "验证码")
        self.oldPhoneTextField.titleTextField(title: "原手机号码")
        self.oldVerifyCodeTextField.titleTextField(title: "验证码")
        self.commitButton.addBorder(color: nil, width: 0, radius: 4)
    }
    
    override func bindViewModel() {
        
        //旧手机号
        let oldPhone = self.oldPhoneTextField.rx.text.orEmpty.asObservable()
            .share(replay: 1)
        
        oldPhone.subscribe(onNext: { [weak self](text) in
            self?.modifyPhone.phoneOld = text
        })
            .disposed(by: dispose)
        oldPhone.map { (text) -> Bool in
            return text.count > 0
            }
            .bind(to: self.oldVerifyButton.rx.isEnabled)
            .disposed(by: dispose)
        
        
        let oldVerifyCode = self.oldVerifyCodeTextField.rx.text.orEmpty.asObservable()
            .share(replay: 1)
        
        oldVerifyCode.subscribe(onNext: { [weak self](text) in
            self?.modifyPhone.verificationCodeOld = text
        })
            .disposed(by: dispose)
        
        self.oldVerifyButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self]() in
                self?.obtainVerifyCode(phone: (self?.modifyPhone.phoneOld)!,isNewPhone: false)
            })
            .disposed(by: dispose)
        
        
        
        //新手机号
        
        let phone = self.phoneTextField.rx.text.orEmpty.asObservable()
            .share(replay: 1)
            
        phone.subscribe(onNext: { [weak self](text) in
                self?.modifyPhone.phone = text
            })
            .disposed(by: dispose)
        phone.map { (text) -> Bool in
            return text.count > 0
            }
            .bind(to: self.verifyButton.rx.isEnabled)
            .disposed(by: dispose)
        
        
        let verifyCode = self.verifyCodeTextField.rx.text.orEmpty.asObservable()
            .share(replay: 1)
            
        verifyCode.subscribe(onNext: { [weak self](text) in
                self?.modifyPhone.verificationCode = text
            })
            .disposed(by: dispose)
        
        self.verifyButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self]() in
                self?.obtainVerifyCode(phone: (self?.modifyPhone.phone)!,isNewPhone: true)
            })
            .disposed(by: dispose)
        
        self.commitButton.rx.tap.asObservable()
            .subscribe(onNext: { () in
                self.commitModifyPhone()
            })
            .disposed(by: dispose)
    }

    
    func timedownVeryCodeButton(isNewPhone: Bool)  {
        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .take(RxTimeInterval(dueTime), scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (time) in
                
                if isNewPhone == true {
                    //是新手机号
                    self?.verifyButton.isEnabled = false
                    self?.verifyButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                    self?.verifyButton.setTitle(String(format: "%ds", (60 - time)), for: UIControlState.normal)
                }else{
                    self?.oldVerifyButton.isEnabled = false
                    self?.oldVerifyButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                    self?.oldVerifyButton.setTitle(String(format: "%ds", (60 - time)), for: UIControlState.normal)
                }
               
                }, onCompleted: { [weak self] in
                    
                    if isNewPhone == true {
                        //是新手机号
                        self?.verifyButton.isEnabled = true
                        self?.verifyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                        self?.verifyButton.setTitle("重新获取", for: UIControlState.normal)
                    }else{
                        self?.oldVerifyButton.isEnabled = true
                        self?.oldVerifyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                        self?.oldVerifyButton.setTitle("重新获取", for: UIControlState.normal)
                    }
                   
            })
            .disposed(by: dispose)
    }

   
    //手机号的时间倒计时
    func obtainVerifyCode(phone:String, isNewPhone: Bool) -> Void {
        self.showLoading()
        BaseApi.request(target: API.registerSms(phone), type: BaseResponseModel<String>.self)
            .subscribe(onNext: { [weak self](data) in
                self?.showSuccess(success: "获取验证码成", complete: nil)
                self?.timedownVeryCodeButton(isNewPhone: isNewPhone)
            }, onError: { (error) in
                self.showFail(fail: error.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
    }
    //提交修改
    func commitModifyPhone() -> Void {
        if self.inputIsOk() {
            self.showLoading()
            BaseApi.request(target: API.updatePhone(self.modifyPhone), type: BaseResponseModel<String>.self)
                .subscribe(onNext: { [weak self](data) in
                    self?.showSuccess(success: data.message, complete: {
                       self?.loginOutHanle()
                    })
                }, onError: { [weak self](error) in
                    self?.showFail(fail: error.localizedDescription, complete: nil)
                })
                .disposed(by: dispose)
        }
       
    }
    
    // 退出登录
    func loginOutHanle() -> Void {
     
        let loginVC = LoginVC()
        let naviVC = UINavigationController(rootViewController: loginVC)
        WDLCoreManager.shared().userInfo = nil
        self.tabBarController?.selectedIndex = 0
        self.present(naviVC, animated: true, completion: nil)
        self.pop(toRootViewControllerAnimation: false)
        
      
    }
    
    func inputIsOk() -> Bool {
        
        if self.modifyPhone.phoneOld.count == 0 {
            self.showWarn(warn: "请输入原手机手机号", complete: nil)
            return false
        }
        if self.modifyPhone.phone.count == 0 {
            self.showWarn(warn: "请输入新手机号", complete: nil)
            return false
        }
        if self.modifyPhone.verificationCodeOld.count == 0 {
            self.showWarn(warn: "请输入原手机手机号的验证码", complete: nil)
            return false
        }
        if self.modifyPhone.verificationCode.count == 0 {
            self.showWarn(warn: "请输入新手机手机号的验证码", complete: nil)
            return false
        }
        
        return true
    }
}
