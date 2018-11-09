//
//  ModityPasswordVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/3.
//  Copyright © 2018 yinli. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ModityPasswordVC: NormalBaseVC {
    
    
    @IBOutlet weak var confirmPwdTextField: UITextField!
    @IBOutlet weak var newPwdTextField: UITextField!
    @IBOutlet weak var oldPwdTextField: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    
    private var pwdModify:ModifyPasswordModel = ModifyPasswordModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func currentConfig() {
        self.oldPwdTextField.titleTextField(title: "原密码")
        self.newPwdTextField.titleTextField(title: "新密码")
        self.confirmPwdTextField.titleTextField(title: "确认密码")
        self.confirmButton.addBorder(color: nil, width: 0, radius: 5)
    }
    
    
    override func bindViewModel() {
        self.oldPwdTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self](text) in
                self?.pwdModify.oldPassword = text
            })
            .disposed(by: dispose)
        self.newPwdTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self](text) in
                self?.pwdModify.password = text
            })
            .disposed(by: dispose)
        self.confirmPwdTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self](text) in
                self?.pwdModify.verificationPassword = text
            })
            .disposed(by: dispose)
        self.confirmButton.rx.tap.asObservable()
            .subscribe(onNext: { [weak self]() in
                self?.modifyPwdHandle()
            })
            .disposed(by: dispose)
        
    }
    
    
    func modifyPwdHandle() -> Void {
        if self.verifyInputIsOk() {
            self.showLoading()
            BaseApi.request(target: API.updatePassword(self.pwdModify), type: BaseResponseModel<String>.self)
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
    
    func verifyInputIsOk() -> Bool {
        if self.pwdModify.oldPassword.count == 0 {
            self.showWarn(warn: "请输入原密码", complete: nil)
            return false
        }
        if self.pwdModify.password.count == 0 {
            self.showWarn(warn: "请输入新密码", complete: nil)
            return false
        }
        if self.pwdModify.verificationPassword.count == 0 {
            self.showWarn(warn: "请输入确认密码", complete: nil)
            return false
        }
        if self.pwdModify.verificationPassword != self.pwdModify.password {
            self.showWarn(warn: "确认密码不正确", complete: nil)
            return false
        }
        return true
    }

}
