//
//  ApiConfig.swift
//  SCM
//
//  Created by 黄露 on 2018/7/27.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import HandyJSON
import Moya


// 对业务进行处理
struct HandleResponse {
    
    // 进行响应的 处理， 业务错误
    static func handleResponse<T:BaseResponse>(response:T?) throws -> T? {
        guard let res = response else {
            throw CustomerError.businessError("网络异常，请重试...")
        }
        if let code = res.code {
            if code == 1 {
                throw CustomerError.globalError(res.message, 1)
            }
            else if code == 3 {
                throw CustomerError.businessError(res.message)
            }
            else if code == 0 || code == 200 {
                return res
            }
            else {
                throw CustomerError.businessError(res.message)
            }
        }
        return res
    }
}

