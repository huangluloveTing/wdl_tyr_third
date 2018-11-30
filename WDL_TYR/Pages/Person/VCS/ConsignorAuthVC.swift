//
//  ConsignorAuthVC.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/10/15.
//  Copyright © 2018年 yinli. All rights reserved.
//

import UIKit

class ConsignorAuthVC: NormalBaseVC {
    
    @IBOutlet weak var companyNameTextField: UITextField!
    @IBOutlet weak var companyIntroTextField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var linkManTextField: UITextField!
    @IBOutlet weak var companyAddressTextField: UITextField!
    @IBOutlet weak var legalPersonIdNoTextField: UITextField!
    @IBOutlet weak var idCardOpsiteImageView: UIImageView!
    @IBOutlet weak var idCardMainImageView: UIImageView!
    @IBOutlet weak var legalPersonTextField: UITextField!
    @IBOutlet weak var liencesImageView: UIImageView!
    @IBOutlet weak var liencesNoTextField: UITextField!
    
    public var authModel:AuthConsignorVo = AuthConsignorVo()
    
    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initInfo() -> Void {
        self.companyNameTextField.text = authModel.companyName
        self.companyIntroTextField.text = authModel.companyAbbreviation
        self.linkManTextField.text = authModel.consignorName
        self.companyAddressTextField.text = authModel.officeAddress
        self.liencesNoTextField.text = authModel.businessLicenseNo
        self.legalPersonTextField.text = authModel.legalPerson
        self.legalPersonIdNoTextField.text = authModel.legalPersonId
        Util.showImage(imageView: self.logoImageView, imageUrl: authModel.companyLogo ,placeholder: UIImage.init(named: "认证-企业logo")!)
        Util.showImage(imageView: self.liencesImageView, imageUrl: authModel.businessLicense , placeholder: UIImage.init(named: "认证-营业执照")!)
        Util.showImage(imageView: self.idCardMainImageView, imageUrl: authModel.legalPersonIdFrontage , placeholder: UIImage.init(named: "我的认证-身份证人像页")!)
        Util.showImage(imageView: self.idCardOpsiteImageView, imageUrl: authModel.legalPersonIdOpposite , placeholder: UIImage.init(named: "我的认证-身份证")!)
        let status = WDLCoreManager.shared().userInfo?.status
        if status == .autherized {
            companyNameTextField.isUserInteractionEnabled = false
            self.companyIntroTextField.isUserInteractionEnabled = false
            self.linkManTextField.isUserInteractionEnabled = true
            self.companyAddressTextField.isUserInteractionEnabled = true
            self.liencesNoTextField.isUserInteractionEnabled = false
            self.legalPersonTextField.isUserInteractionEnabled = false
            self.legalPersonIdNoTextField.isUserInteractionEnabled = false
            self.logoImageView.isUserInteractionEnabled = false
            self.liencesImageView.isUserInteractionEnabled = false
            self.idCardMainImageView.isUserInteractionEnabled = false
            self.idCardOpsiteImageView.isUserInteractionEnabled = false
        }
    }
    
    override func currentConfig() {
        self.bottomView.shadow(color: UIColor(hex: COLOR_SHADOW), offset: CGSize(width: 0, height: -2), opacity: 0.5, radius: 2)
        self.companyNameTextField.titleTextField(title: "企业名称")
        self.companyIntroTextField.titleTextField(title: "企业简介")
        self.linkManTextField.titleTextField(title: "联系人")
        self.companyAddressTextField.titleTextField(title: "办公地址")
        self.liencesNoTextField.titleTextField(title: "营业执照号")
        self.legalPersonTextField.titleTextField(title: "法人姓名")
        self.legalPersonIdNoTextField.titleTextField(title: "法人身份证号")
        
        // logo
        self.logoImageView.singleTap { [weak self](_) in
            self?.takePhotoAlert(closure: { (image) in
                self?.uploadImage(image: image ,
                                  imageView: (self?.logoImageView)! ,
                                  mode: .license_path, callBack: {(imgUrl) in
                    self?.authModel.companyLogo = imgUrl
                })
            })
        }
        
        // 点击营业执照
        self.liencesImageView.singleTap { [weak self](_) in
            self?.takePhotoAlert(closure: { (image) in
                self?.uploadImage(image: image, imageView: (self?.liencesImageView)!, mode: .license_path, callBack: { (path) in
                    self?.authModel.businessLicense = path
                })
            })
        }
        
        // 点击身份证正面
        self.idCardMainImageView.singleTap { [weak self](_) in
            self?.takePhotoAlert(closure: { (image) in
                self?.uploadImage(image: image, imageView: (self?.idCardMainImageView)!, mode: .card_path, callBack: { (path) in
                    self?.authModel.legalPersonIdFrontage = path
                })
            })
        }
        
        // 点击身份证背面面
        self.idCardOpsiteImageView.singleTap { [weak self](view) in
            self?.takePhotoAlert(closure: { (image) in
                self?.uploadImage(image: image, imageView: (self?.idCardOpsiteImageView)!, mode: .card_path, callBack: { (path) in
                    self?.authModel.legalPersonIdOpposite = path
                })
            })
        }
    }
    
    override func bindViewModel() {
        self.initInfo()
        self.companyNameTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self](text) in
                self?.authModel.companyName = text
            })
            .disposed(by: dispose)
        
        self.companyIntroTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self](text) in
                self?.authModel.companyAbbreviation = text
            })
            .disposed(by: dispose)
        
        self.linkManTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self](text) in
                self?.authModel.consignorName = text
            })
            .disposed(by: dispose)
        
        self.companyAddressTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self](text) in
                self?.authModel.officeAddress = text
            })
            .disposed(by: dispose)
        
        self.liencesNoTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self](text) in
                self?.authModel.businessLicenseNo = text
            })
            .disposed(by: dispose)
        
        self.legalPersonTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self](text) in
                self?.authModel.legalPerson = text
            })
            .disposed(by: dispose)
        
        self.legalPersonIdNoTextField.rx.text.orEmpty.asObservable()
            .subscribe(onNext: { [weak self](text) in
                self?.authModel.legalPersonId = text
            })
            .disposed(by: dispose)
    }
    
    //MARK: - commit
    @IBAction func commitHandle(_ sender: Any) {
        if canCommitAuth() == true {
            self.showLoading()
            BaseApi.request(target: API.corporateCertification(self.authModel), type: BaseResponseModel<String>.self)
                .retry(5)
                .subscribe(onNext: { [weak self](data) in
                    self?.showSuccess(success: data.message, complete: {
                        self?.pop(toRootViewControllerAnimation: true)
                    })
                    }, onError: { [weak self](error) in
                        self?.showFail(fail: error.localizedDescription, complete: nil)
                })
                .disposed(by: dispose)
        }
    }
    
    //MARK: - 判断是否可以提交
    func canCommitAuth() -> Bool {
        if (self.authModel.companyName?.count ?? 0) <= 0 {
            self.showWarn(warn: "请填写企业名称", complete: nil)
            return false
        }
        if (self.authModel.companyAbbreviation?.count ?? 0) <= 0 {
            self.showWarn(warn: "请填写企业简称", complete: nil)
            return false
        }
        if (self.authModel.companyLogo?.count ?? 0) <= 0 {
            self.showWarn(warn: "请上传企业logo", complete: nil)
            return false
        }
        if (self.authModel.consignorName?.count ?? 0) <= 0 {
            self.showWarn(warn: "请填写联系人", complete: nil)
            return false
        }
        if (self.authModel.officeAddress?.count ?? 0) <= 0 {
            self.showWarn(warn: "请填写办公地址", complete: nil)
            return false
        }
        if (self.authModel.businessLicenseNo?.count ?? 0) <= 0 {
            self.showWarn(warn: "请填写营业执照号", complete: nil)
            return false
        }
        if (self.authModel.businessLicense?.count ?? 0) <= 0 {
            self.showWarn(warn: "填上传企业营业执照", complete: nil)
            return false
        }
        if (self.authModel.legalPerson?.count ?? 0) <= 0 {
            self.showWarn(warn: "请填写法人姓名", complete: nil)
            return false
        }
        if (self.authModel.legalPersonId?.count ?? 0) <= 0 {
            self.showWarn(warn: "请填写法人身份证号码", complete: nil)
            return false
        }
        if (self.authModel.legalPersonIdFrontage?.count ?? 0) <= 0 {
            self.showWarn(warn: "请上传法人身份证正面照", complete: nil)
            return false
        }
        if (self.authModel.legalPersonIdOpposite?.count ?? 0) <= 0 {
            self.showWarn(warn: "请上传法人身份证背面照", complete: nil)
            return false
        }
        return true
    }
}

extension ConsignorAuthVC {
    
    func uploadImage(image:UIImage? , imageView:UIImageView , mode:UploadImagTypeMode , callBack:((String?) -> ())?) -> Void {
        self.showLoading()
        BaseApi.request(target: API.uploadImage(image! , mode), type: BaseResponseModel<[String]>.self)
            .retry(5)
            .subscribe(onNext: {[weak self] (data) in
                self?.showSuccess(success: data.message, complete: nil)
                imageView.image = image
                if let callBakc = callBack {
                    callBakc(data.data?.first)
                }
            }, onError: { [weak self](error) in
                self?.showFail(fail: error.localizedDescription, complete: nil)
            })
            .disposed(by: dispose)
    }
}
