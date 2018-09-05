//
//  ZTDismissTransition.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/9/5.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

class ZTDismissTransition: NSObject {

    private var _duration:TimeInterval = 0.4
    private var _topHeight:CGFloat = IPHONE_HEIGHT / 3.0
    
    public var duration:TimeInterval {
        set {
            _duration = newValue
        }
        get {
            return _duration
        }
    }
    
    public var topHeight:CGFloat {
        set {
            _topHeight = newValue
        }
        get {
            return _topHeight
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) ?? transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)?.view
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) ?? transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)?.view
        let maskView = UIView(frame: containerView.bounds)
//        maskView.backgroundColor = TransitionMaskColor
        
        containerView.backgroundColor = UIColor.clear
        containerView.addSubview(fromView!)
        containerView.addSubview(maskView)
        containerView.addSubview(toView!)
        
        fromView!.frame = containerView.bounds
        toView!.frame = containerView.bounds
        
        var toViewFrame = toView!.frame
        toViewFrame.origin.y = toViewFrame.size.height
        toViewFrame.size.height = toViewFrame.size.height - self.topHeight
        toView!.frame = toViewFrame
        
        UIView.animate(withDuration: self.duration, animations: {
            toViewFrame.origin.y = self.topHeight
            toView!.frame = toViewFrame
        }) { (finish) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}
