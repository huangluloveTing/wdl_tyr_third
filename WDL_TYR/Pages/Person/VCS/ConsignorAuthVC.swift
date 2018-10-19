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
    
    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    }
}
