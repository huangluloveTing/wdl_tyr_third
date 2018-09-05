//
//  ZTTransitionManager.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class ZTTransitionManager: NSObject {
    
    static func halfTransparentTransition(duration:TimeInterval = 0.4 , topHeight:CGFloat = IPHONE_HEIGHT / 3.0) -> UIViewControllerAnimatedTransitioning? {
        let transition = ZTTransition()
        transition.duration = duration
        transition.topHeight = topHeight
        return transition
    }
    
    static func halfDissmissTransition(duration:TimeInterval = 0.4) -> UIViewControllerAnimatedTransitioning? {
        let transition = ZTTransition()
        transition.duration = duration
        transition.isDismiss = true
        return transition
    }
}
