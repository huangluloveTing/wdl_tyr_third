//
//  AppDelegate+jpush.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/11/30.
//  Copyright © 2018 yinli. All rights reserved.
//

import Foundation

extension AppDelegate {
    func registerJPush() {
        let entity = JPUSHRegisterEntity()
        if #available(iOS 12.0, *) {
            entity.types = Int(JPAuthorizationOptions.alert.rawValue|JPAuthorizationOptions.badge.rawValue|JPAuthorizationOptions.sound.rawValue|JPAuthorizationOptions.providesAppNotificationSettings.rawValue)
        } else {
            entity.types = Int(JPAuthorizationOptions.alert.rawValue|JPAuthorizationOptions.badge.rawValue|JPAuthorizationOptions.sound.rawValue)
        }
        if (Float(UIDevice.current.systemVersion) ?? 0) >= 8 {
            
        }
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
        
    }
    
    func initJPush(lanchOptions:[UIApplicationLaunchOptionsKey: Any]?) -> Void {
        var production = true
        #if DEBUG
            production = false
        #endif
        JPUSHService.setup(withOption: lanchOptions,
                           appKey: JPushAppKey,
                           channel: "App store",
                           apsForProduction: production)
    }
    
    func registerToken(token:Data) -> Void {
        JPUSHService.registerDeviceToken(token)
    }
    
  
    
 
}

extension AppDelegate : JPUSHRegisterDelegate {
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, openSettingsFor notification: UNNotification?) {
        
    }
    
    
    // MARK: JPUSHRegisterDelegate
    // iOS 10 Support
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以选择设置
        completionHandler(Int(UNNotificationPresentationOptions.alert.rawValue|UNNotificationPresentationOptions.sound.rawValue|UNNotificationPresentationOptions.badge.rawValue))
    }
    
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        print(">JPUSHRegisterDelegate jpushNotificationCenter didReceive");
        let userInfo = response.notification.request.content.userInfo
        print("打印极光推送消息内容\(userInfo as NSDictionary)")
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))!{
            JPUSHService.handleRemoteNotification(userInfo)
        }
        //角标清空
        JPUSHService.setBadge(0)
        UIApplication.shared.applicationIconBadgeNumber = 0
        completionHandler()
        
        //自定义跳转界面方法,也可以根据需要在首页做监听事件
//        let userDic = userInfo as NSDictionary
    }
}

