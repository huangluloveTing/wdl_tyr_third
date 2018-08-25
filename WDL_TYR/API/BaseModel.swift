//
//  BaseReponse.swift
//  SCM
//
//  Created by 黄露 on 2018/7/26.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import HandyJSON

public protocol BaseResponse: HandyJSON {
    
    associatedtype Element

    var code:Int?{ get set }
    var remark:String?{ get set }
    var result:Element? { get set }
}

struct BaseResponseModel<T:Any> : BaseResponse {
    
    typealias Element = T
    
    var result: T?
    
    var code: Int?
    
    var remark: String?
}

public enum CustomerError : Error{
    case paramError(String?)
    case businessError(String?)
    case netError(String?)
    case httpFailed(String? , Int)
    case serialDataError(String?)
    case globalError(String? , Int)
}


extension CustomerError:LocalizedError {
    public var errorDescription:String? {
        switch self {
        case .paramError(let message):
            return message
        case .businessError(let message):
            return message
        case .netError(let message):
            return message
        case .httpFailed(let message, _):
            return message
        case .serialDataError(let message):
            return message
        case .globalError(let message, _):
            return message
        }
    }
}


