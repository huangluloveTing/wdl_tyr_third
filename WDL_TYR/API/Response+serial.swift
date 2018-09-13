//
//  ApiExtension.swift
//  SCM
//
//  Created by 黄露 on 2018/7/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import RxSwift
import HandyJSON
import Moya


import Foundation

extension ObservableType where E == Response {
    public func mapModel<T: BaseResponse>(_ type: T.Type) -> Observable<T> {
        return flatMap { response -> Observable<T> in
            let resModel = response.mapModel(type: T.self)
            guard let reuslt = resModel else {
                throw CustomerError.serialDataError("数据解析异常")
            }
            
            do {
                let newResult = try HandleResponse.handleResponse(response: reuslt)
                return Observable.just(newResult!)
            }
            catch let error {
                throw error
            }
        }
    }
}

extension Response {
    func mapModel<T:BaseResponse>(type:T.Type) -> T? {
        let json = String.init(data: data, encoding: .utf8)
        print("\(json ?? "")")
        let res = JSONDeserializer<T>.deserializeFrom(json: json)
        return res
    }
}
