//
//  PersonModels.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/10/15.
//  Copyright © 2018年 yinli. All rights reserved.
//

import Foundation
import HandyJSON

enum ConsignorType:Int , HandyJSONEnum {
    case agency  = 1
    case third = 2
}

//0:未审核，1：审核中，2：审核失败，3：审核中
enum AutherizStatus:Int , HandyJSONEnum {
    case not_start = 0
    case autherizing = 1
    case autherizedFail = 2
    case autherized = 3
}

struct ZbnConsignor : HandyJSON {
    var businessLicense:String? // 营业执照
    var businessLicenseNo:String? //营业执照号
    var cellPhone:String? // h手机号码
    var companyAbbreviation:String? //企业简称
    var companyLogo:String?     //企业logo
    var companyName:String?     //企业名称 
    var consignorName:String?   // 联系人
    var consignorNo:String?     // 托运人ID
    var consignorType:ConsignorType? //属性 1=经销商 2=第三方 ,
    var createTime:TimeInterval = 0
    var endTime:TimeInterval = 0
    var id:String = ""
    var legalPerson:String? // 法人姓名 
    var legalPersonId:String?   //法人身份证号
    var legalPersonIdFrontage:String?   // 法人身份证正面照
    var legalPersonIdOpposite:String?   //法人身份证反面照
    var officeAddress:String? // (string): 办公地址 ,
    var passWord :String? // (string): 密码 ,
    var remark : String? // (string): 备注 ,
    var score : Float = 0 // (number): 平分 ,
    var startTime : TimeInterval = 0 // (string): 开始时间 ,
    var status : AutherizStatus = .not_start // (integer): 状态(0:未审核，1：审核中，2：审核失败，3：审核中) ,
    var transactionCount : Int = 0 // (integer): 成交数量
}

//驾驶证上传路径：upload_driverLicense_filePath
//行驶证上传路径：upload_vehicleLicense_filePath
//道路运输证上传路径：upload_roadTransportCertificate_filePath
//运单回单上传路径：upload_transport_return_filePath
enum UploadImagTypeMode:String {
    case driverLicense = "upload_driverLicense_filePath"
    case vehicle = "upload_vehicleLicense_filePath"
    case roadTransportCertificate = "upload_roadTransportCertificate_filePath"
    case transport_return = "upload_transport_return_filePath"
}
