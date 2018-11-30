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
    
    // iOS 10 Support
    @available(iOS 10.0, *)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if response.notification.request.trigger is UNPushNotificationTrigger {
            JPUSHService.handleRemoteNotification(userInfo)
        }
        // 系统要求执行这个方法
        completionHandler()
    }
    
    //    - (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler;
    
    //    - (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler;
    
    //    - (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(nullable UNNotification *)notification NS_AVAILABLE_IOS(12.0);
}

