//
//  UserDefault.swift
//  SCM
//
//  Created by 黄露 on 2018/7/30.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

public class UserDefault {
    static public func storeInfo(key : String , info:Any?) {
        UserDefaults.standard.set(info, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
    static public func loadInfo(key:String)  -> Any? {
           return UserDefaults.standard.value(forKey: key)
    }
    
    static public func clearInfo(key:String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
