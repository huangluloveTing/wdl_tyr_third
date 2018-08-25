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
            if code == 902 {
                throw CustomerError.globalError(res.remark, 902)
            }
            else if code == 903 {
                throw CustomerError.businessError(res.remark)
            }
            else if code >= 200 && code <= 299 {
                return res
            }
            else {
                throw CustomerError.businessError(res.remark)
            }
        }
        return res
    }
}

