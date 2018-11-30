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
        self.commitButton.addBorder(color: nil, width: 0, radius: 4)
    }
    
    override func bindViewModel() {
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
                self?.obtainVerifyCode(phone: (self?.modifyPhone.phone)!)
            })
            .disposed(by: dispose)
        
        self.commitButton.rx.tap.asObservable()
            .subscribe(onNext: { () in
                self.commitModifyPhone()
            })
            .disposed(by: dispose)
    }

    
    func timedownVeryCodeButton()  {
        Observable<Int>.interval(1, scheduler: MainScheduler.instance)
            .take(RxTimeInterval(dueTime), scheduler: MainScheduler.instance)
            .subscribe(onNext: {[weak self] (time) in
                self?.verifyButton.titleLabel?.font = UIFont.systemFont(ofSize: 17)
                self?.verifyButton.setTitle(String(format: "%ds", (60 - time)), for: UIControlState.normal)
                }, onCompleted: { [weak self] in
                    self?.verifyButton.isEnabled = true
                    self?.verifyButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
                    self?.verifyButton.setTitle("重新获取", for: UIControlState.normal)
            })
            .disposed(by: dispose)
    }

    
    func obtainVerifyCode(phone:String) -> Void {
        BaseApi.request(target: API.registerSms(phone), type: BaseResponseModel<String>.self)
            .subscribe(onNext: { [weak self](data) in
                self?.timedownVeryCodeButton()
            }, onError: { (error) in
                self.showFail(fail: error.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
    }
    
    func commitModifyPhone() -> Void {
        if self.inputIsOk() {
            self.showLoading()
            BaseApi.request(target: API.updatePhone(self.modifyPhone), type: BaseResponseModel<String>.self)
                .subscribe(onNext: { [weak self](data) in
                    self?.showSuccess(success: data.message, complete: {
                        self?.pop()
                    })
                }, onError: { [weak self](error) in
                    self?.showFail(fail: error.localizedDescription, complete: nil)
                })
                .disposed(by: dispose)
        }
       
    }
    
    
    func inputIsOk() -> Bool {
        return true
    }
}
