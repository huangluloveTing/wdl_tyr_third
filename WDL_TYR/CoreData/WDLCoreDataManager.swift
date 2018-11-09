//
//  wdlCoreDataManager.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/7.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import HandyJSON

//"pageNum": 0,
//"pageSize": 0,
//"startTime": null,
//"endTime": null,
//"token": "Q2Q3MmFhMDlkMWY4MjRiMGRiOGZlNjg1NDRhNGJlMjY2",
//"id": "d72aa09d1f824b0db8fe68544a4be266",
//"consignorNo": null,
//"createTime": 1536459959157,
//"companyName": null,
//"companyAbbreviation": null,
//"companyLogo": null,
//"consignorName": null,
//"cellPhone": "18011360791",
//"officeAddress": null,
//"businessLicenseNo": null,
//"businessLicense": null,
//"legalPerson": null,
//"legalPersonId": null,
//"legalPersonIdFrontage": null,
//"legalPersonIdOpposite": null,
//"consignorType": 2,
//"status": 1,
//"remark": null,
//"passWord": "e10adc3949ba59abbe56e057f20f883e"
struct LoginInfo : HandyJSON {
    public var token:String?
    public var id:String?
    public var consignorNo:String?
    public var cellPhone:String?
}

class WDLCoreManager: NSObject {
    
    public var regionAreas:[RegionModel]?
    
    public var userInfo: LoginInfo?
    
    private static let instance = WDLCoreManager()
    private override init() {}
    
    public static func shared() -> WDLCoreManager {
        return instance
    }
    
    
}
