//
//  PictureBroweManager.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/30.
//  Copyright © 2018 yinli. All rights reserved.
//

import Foundation


class PictureBroweManager: NSObject {
    
    static let manager = PictureBroweManager()
    
    private override init() {
        
    }
    
    static func shard() -> PictureBroweManager {
        return manager
    }
    
    func showPictures(imgs:[UIImage] , imageForView:[UIImageView]) -> Void {
        
    }
    
}

