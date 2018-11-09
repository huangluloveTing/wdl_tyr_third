//
//  String+Extension.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/11.
//  Copyright © 2018年 yingli. All rights reserved.
//

import Foundation

extension String {
    
    func stringISOk() -> Bool {
        if self.count == 0  {
            return false
        }
        if self.trimmingCharacters(in: CharacterSet.whitespaces).count == 0 {
            return false
        }
        return true
    }
    
}
