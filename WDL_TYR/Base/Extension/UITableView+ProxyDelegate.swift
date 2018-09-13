//
//  UITableView+ProxyDelegate.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/12.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UITableViewProxyDelegate: DelegateProxy<UITableView , UITableViewDelegate> , UITableViewDelegate , DelegateProxyType {
    static func registerKnownImplementations() {
        self.register { (parent) -> UITableViewProxyDelegate in
            return parent
        }
    }
    
    static func currentDelegate(for object: UITableView) -> UITableViewDelegate? {
        return object.delegate
    }
    
    static func setCurrentDelegate(_ delegate: UITableViewDelegate?, to object: UITableView) {
        object.delegate = delegate
    }
}


extension Reactive where Base:UITableView {
    
    
}
