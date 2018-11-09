//
//  Regx.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/9.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

//手机号码验证
func isPhone(phone:String?) -> Bool {
    let mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
    let  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
    let  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
    let  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
    let regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
    let regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
    let regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
    let regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
    if ((regextestmobile.evaluate(with: phone) == true)
        || (regextestcm.evaluate(with: phone)  == true)
        || (regextestct.evaluate(with: phone) == true)
        || (regextestcu.evaluate(with: phone) == true))
    {
        return true
    }
    else
    {
        return false
    }
}
//暂时不加限制
func isCorrectPwd(pwd:String?) -> Bool {
    return true
}
