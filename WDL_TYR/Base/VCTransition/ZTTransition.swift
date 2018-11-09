//
//  ZTTransition.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/23.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit

fileprivate let TransitionMaskColor = UIColor(hex: "292B2A").withAlphaComponent(0.6)

class ZTTransition: NSObject , UIViewControllerAnimatedTransitioning {
    
    public var currentTransitionContext:UIViewControllerContextTransitioning?
    
    private var _duration:TimeInterval = 0.4
    private var _topHeight:CGFloat = IPHONE_HEIGHT / 3.0
    
    public var isDismiss:Bool = false
    
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
        if self.isDismiss == true {
            animationForDismissedView(transitionContext: transitionContext)
            return
        }
        animationForPresentedView(transitionContext: transitionContext)
    }
    
    /// 定义显示动画
    func animationForPresentedView(transitionContext: UIViewControllerContextTransitioning) {
        self.currentTransitionContext = transitionContext
        // 1.取出弹出的View
        // Key有两个值可以选 UITransitionContextFromViewKey(消失的View), and UITransitionContextToViewKey(显示的View)
        let presentedView = transitionContext.viewController(forKey: .to)?.view
        let containerView = transitionContext.containerView
        // 2.将presentedView添加到容器视图containerView中
        let maskView = UIView(frame: containerView.bounds)
        maskView.backgroundColor = TransitionMaskColor
        let tap = UITapGestureRecognizer(target: self, action: #selector(singleTap))
        maskView.addGestureRecognizer(tap)
        containerView.addSubview(maskView)
        containerView.addSubview(presentedView!)
        
        presentedView?.frame = transitionContext.containerView.bounds
        presentedView?.zt_y = containerView.zt_height
        presentedView?.zt_height = containerView.zt_height - self.topHeight
        // 3.执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            // 执行的动画内容
            presentedView?.zt_y = self.topHeight
        }) { (_) in
            // 告诉上下文已完成动画
            transitionContext.completeTransition(true)
        }
    }
    
    @objc func singleTap() {
        let toVC = self.currentTransitionContext?.viewController(forKey: .to)
        toVC?.dismiss(animated: true, completion: nil)
    }
    
    /// 定义消失动画
    func animationForDismissedView(transitionContext: UIViewControllerContextTransitioning) {
        // 1.取出消失的View
        let dismissedView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let containerView = transitionContext.containerView
        
        // 2.执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            // 执行的动画内容
            dismissedView?.zt_y = containerView.zt_height
        }) { (_) in
            // 将消失的view从父控制器里移除
            dismissedView?.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }
}
