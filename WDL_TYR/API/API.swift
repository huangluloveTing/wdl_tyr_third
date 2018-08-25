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
    case login(String , String)
    case getTaskList(Int , Int , Int)
    case getQuotaTaskItemList(String)
    case getOrderList(Int , Int , Int)
    case getOrderDetailItems(String , String)
}

extension API :TargetType {
    
    var baseURL: URL {
        return URL.init(string: "http://test.ylfood.com/scm-web/")!
    }
    
    var path: String {
        switch self {
            case .login(_, _):
                return "scmApp/login"
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
        
    
    var method:Moya.Method {
        switch self {
        case .login(_, _):
            return .post
        default:
            return .get
        }
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
        case .getTaskList(let start , let limit, let status):
            var params = getPageParams(start: start, limit: limit)
            params["status"] = status
            return  .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .login(let account , let pwd):
            return .requestParameters(parameters: ["loginName":account,"loginPasswd":pwd], encoding: JSONEncoding.default)
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
    
    var headers: [String : String]? {
        return ["content-type":"application/json" , "deviceType":"ios" , "token": "quyali_297_83fa7221f1b0436546af6c8c1ade4e59"];
    }
    
    
    private func getPageParams( start:Int = 0, limit:Int = 10) -> [String : Any] {
        return ["start":start , "limit":limit]
    }
    
}


