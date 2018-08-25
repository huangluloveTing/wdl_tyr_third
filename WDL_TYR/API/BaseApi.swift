//
//  business.swift
//  SCM
//
//  Created by 黄露 on 2018/7/20.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import Moya
import Result
import RxSwift
import HandyJSON


struct BaseApi {
    
    private static let provider = MoyaProvider<API>(plugins: [])
    
    static func request<T: BaseResponse>(target:API, type:T.Type) -> Observable<T> {
        let observable = provider.rx.request(target).asObservable()
            .mapModel(T.self)
        return observable
    }
}

struct MyPlugins: PluginType {
    func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        return request
    }
    func willSend(_ request: RequestType, target: TargetType) {
        
    }
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        
    }
    func process(_ result: Result<Moya.Response, MoyaError>, target: TargetType) -> Result<Moya.Response, MoyaError> {
        return result
    }
}
