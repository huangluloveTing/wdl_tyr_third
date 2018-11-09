//
//  Demo.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/10/15.
//  Copyright © 2018年 yinli. All rights reserved.
//

import Foundation

public final class MyCla<Base> {
    private var base:Base
    init(base:Base) {
        self.base = base
    }
}


protocol MyProtocol {
    associatedtype Base
    var de:Base { get }
}

extension MyProtocol {
    var de:MyCla<Self> {
        return MyCla(base: self)
    }
}
