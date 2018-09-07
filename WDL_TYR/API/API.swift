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
    case login(String , String) // 登录接口
    case register(String , String , String , String) // 注册
    case registerSms(String)    // 获取验证码
    case getTaskList(Int , Int , Int)
    case getQuotaTaskItemList(String)
    case getOrderList(Int , Int , Int)
    case getOrderDetailItems(String , String)
}


// PATH
func apiPath(api:API) -> String {
    switch api {
    case .login(_, _):
        return ""
    case .register(_, _, _, _):
        return "/consignor/consignorRegister"
    case .registerSms(_):
        return "/consignor/consignorRegisterSms"
    case .getTaskList(_, _, _):
        return "scmApp/getTaskList"
    case .getQuotaTaskItemList(_):
        return "scmApp/getQuotaTaskItemList"
        
    case .getOrderList(_, _, _):
        return "scmApp/getOrderList"
        
    case .getOrderDetailItems(_, _):
        return "scmApp/getOrderDetailItems"
    }
}

// TASK
func apiTask(api:API) -> Task {
    switch api {
    case .registerSms(let phpne):
        return .requestParameters(parameters: ["cellphone":phpne], encoding:JSONEncoding.default)
    case .register(let pwd, let phone, let vcode, let vpwd):
        return .requestParameters(parameters: ["password": pwd,"phone": phone,"verificationCode": vcode,"verificationPassword": vpwd], encoding: JSONEncoding.default)
    case .getTaskList(let start , let limit, let status):
        var params = getPageParams(start: start, limit: limit)
        params["status"] = status
        return  .requestParameters(parameters: params, encoding: URLEncoding.default)
    case .login(let account , let pwd):
        return .requestParameters(parameters: ["username":account,"passwd":pwd], encoding: JSONEncoding.default)
    case .getQuotaTaskItemList(let planCode):
        return .requestParameters(parameters: ["planCode":planCode], encoding: URLEncoding.default)
        
    case .getOrderList(let start, let limit, let status):
        var params = getPageParams(start: start, limit: limit)
        params["status"] = status
        return  .requestParameters(parameters: params, encoding: URLEncoding.default)
        
    case .getOrderDetailItems(let orderCode, let planCode):
        return .requestParameters(parameters: ["planCode":planCode , "orderCode":orderCode], encoding: URLEncoding.default)
    }
}

// METHOD
func apiMethod(api:API) -> Moya.Method {
    return .post
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
        return [String:String]();
    }
    
}


