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
    case loadTaskInfo()
}


// PATH
func apiPath(api:API) -> String {
    switch api {
    case .login(_, _):
        return "/auth/login"
    case .register(_, _, _, _):
        return "/consignor/consignorRegister"
    case .registerSms(_):
        return "/consignor/consignorRegisterSms"
    case .loadTaskInfo():
        return "/app/common/getAllCityAreaList"
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
        return .requestParameters(parameters: ["username":account,"passwd":pwd], encoding: JSONEncoding.default)
        
    case .loadTaskInfo():
        return .requestPlain
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
        return ["Content-Type": "application/json",
                "Accept": "application/json"];
    }
    
}


