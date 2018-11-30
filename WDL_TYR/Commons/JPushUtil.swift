//
//  JPushUtil.swift
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
//        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
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

extension AppDelegate {
    
//    - (void)jpushNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(NSInteger options))completionHandler;

//    - (void)jpushNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler;
    
//    - (void)jpushNotificationCenter:(UNUserNotificationCenter *)center openSettingsForNotification:(nullable UNNotification *)notification NS_AVAILABLE_IOS(12.0);
    
}
