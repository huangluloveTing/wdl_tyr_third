//
//  api.swift
//  SCM
//
//  Created by 黄露 on 2018/7/20.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import Moya

import Alamofire

enum API {
    case login(String , String)             // 登录接口
    case register(String , String , String , String) // 注册
    case registerSms(String)                // 获取验证码
    case loadTaskInfo()                     // 获取省市区
    case getCreateHallDictionary()          // 获取数据字典
    case releaseSource(ReleaseDeliverySourceModel)       // 发布货源
    case ownOrderHall(GoodsSupplyQueryBean) // 我的货源接口
    case getOfferByOrderHallId(QuerySupplyDetailBean)    // 获取报价详情
    case onShelf(String)                    // 手动上架
    case undercarriage(String)              // 手动下架
    case orderHallManualTransaction(String , String) // 手动成交
    case deleteOrderHall(String)            // 删除货源
    case ownTransportPage(QuerytTransportListBean) // 获取我的运单
    case sinGletransaction(String)          // 获取运单详情
    case transportSign(String)              // 运单签收
    case transportTransaction(String)       // 运单起运
    case getZbnConsignor(String)            // 托运人认证信息
}


// PATH
func apiPath(api:API) -> String {
    switch api {
    case .login(_, _):
        return "/consignor/login"
    case .register(_, _, _, _):
        return "/consignor/consignorRegister"
    case .registerSms(_):
        return "/consignor/consignorRegisterSms"
    case .loadTaskInfo():
        return "/app/common/getAllCityAreaList"
    case .getCreateHallDictionary():
        return "/app/common/getCreateHallDictionary"
    case .releaseSource(_):
        return "/orderHall/releaseSource"
    case .ownOrderHall(_):
        return "/orderHall/ownOrderHall"
    case .getOfferByOrderHallId(_):
        return "/orderHall/findOrderHallAndOffer"
    case .onShelf(_):
        return "/orderHall/onShelf"
    case .undercarriage(_):
        return "/orderHall/undercarriage"
    case .deleteOrderHall(_):
        return "/orderHall/deleteOrderHall"
    case .orderHallManualTransaction(_, _):
        return "/orderHall/manualTransaction"
    case .ownTransportPage(_):
        return "/transport/ownTransportPage"
    case .sinGletransaction(_):
        return "/transport/sinGletransaction"
    case .transportSign(_):
        return "/transport/sign"
    case .transportTransaction(_):
        return "/transport/transaction"
    case .getZbnConsignor(_):
        return "/consignor/getZbnConsignor"
    }
}

// TASK
func apiTask(api:API) -> Task {
    switch api {
    case .registerSms(let phpne):
        return .requestCompositeParameters(bodyParameters: [String:String](), bodyEncoding: JSONEncoding.default, urlParameters: ["cellphone":phpne])
    case .register(let pwd, let phone, let vcode, let vpwd):
        return .requestParameters(parameters: ["password": pwd,"phone": phone,"verificationCode": vcode,"verificationPassword": vpwd], encoding: JSONEncoding.default)
    case .login(let account , let pwd):
        return .requestParameters(parameters: ["cellphone":account,"password":pwd], encoding: JSONEncoding.default)
    case .loadTaskInfo():
        return .requestPlain
    case .getCreateHallDictionary():
        return .requestPlain
    case .releaseSource(let resource):
        return .requestParameters(parameters: resource.toJSON()!, encoding: JSONEncoding.default)
    case .ownOrderHall(let query):
        return .requestParameters(parameters: query.toJSON() ?? Dictionary(), encoding: JSONEncoding.default)
    case .getOfferByOrderHallId(let query):
        return .requestParameters(parameters: query.toJSON() ?? Dictionary(), encoding: JSONEncoding.default)
        
    case .onShelf(let id):
        return .requestParameters(parameters: ["hallId" : id], encoding: URLEncoding.default)
        
    case .undercarriage(let hallId):
        return .requestParameters(parameters: ["hallId": hallId], encoding: URLEncoding.default)
        
    case .deleteOrderHall(let id):
        return .requestParameters(parameters: ["hallId": id], encoding: URLEncoding.default)
        
    case .orderHallManualTransaction(let hallId, let offerId):
        return .requestParameters(parameters: ["hallId": hallId , "offerId" : offerId], encoding: JSONEncoding.default)
        
    case .ownTransportPage(let bean):
        return .requestParameters(parameters: bean.toJSON() ?? Dictionary(), encoding: JSONEncoding.default)
        
    case .sinGletransaction(let id):
        return .requestParameters(parameters: ["hallId": id], encoding: URLEncoding.default)
        
    case .transportSign(let code):
        return .requestParameters(parameters: ["transportNo":code], encoding: URLEncoding.default)
        
    case .transportTransaction(let code):
        return .requestParameters(parameters: ["stowageCode":code], encoding: URLEncoding.default)
        
    case .getZbnConsignor(let id):
        return .requestCompositeParameters(bodyParameters: [String:String](), bodyEncoding: JSONEncoding.default, urlParameters: ["id":id])
    }
}

// METHOD
func apiMethod(api:API) -> Moya.Method {
    switch api {
    case .getCreateHallDictionary() ,
         .onShelf(_) ,
         .undercarriage(_) ,
         .sinGletransaction(_) ,
         .transportSign(_) ,
         .transportTransaction(_),
         .getZbnConsignor(_):
        return .get
    default:
        return .post
    }
}

// 分页
private func getPageParams( start:Int = 0, limit:Int = 10) -> [String : Any] {
    return ["start":start , "limit":limit]
}

extension API :TargetType {
    
    var baseURL: URL {
        return URL.init(string: HOST)!
    }
    
    var path: String {
        return apiPath(api: self)
    }
        
    
    var method:Moya.Method {
        return apiMethod(api: self)
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        return apiTask(api: self)
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json",
                "Accept": "application/json"];
    }
    
}


