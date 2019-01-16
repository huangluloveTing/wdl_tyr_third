//
//  AppDelegate.swift
//  WDL_TYR
//
//  Created by 黄露 on 2018/8/20.
//  Copyright © 2018年 yingli. All rights reserved.
//

import UIKit
import RxSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let dispose = DisposeBag()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //初始化配置
        initJPush(lanchOptions: launchOptions)
        //注册设备
        registerJPush()
        autoLogin()
        self.configIQKeyboard()
        self.configGAODEMap()
        self.configHUD()
        self.loadConsignorInfo()
        
//        [[UIApplicationsharedApplication]registerForRemoteNotifications];
        UIApplication.shared.registerForRemoteNotifications()
        //通过这个获取registrationID 发送消息
        JPUSHService.registrationIDCompletionHandler { (resCode, registrationID) in
            if resCode == 0{
                print("registrationID获取成功：\(String(describing: registrationID))")
            }else {
                print("registrationID获取失败：\(String(describing: registrationID))")
            }
        }
        
        //软件更新
        self.updateSoftWare()
        
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        self.loadConsignorInfo()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    //MARK: - 极光
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        JPUSHService.handleRemoteNotification(userInfo)
        completionHandler(UIBackgroundFetchResult.newData)
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        registerToken(token: deviceToken)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        
    }
    
    
}




extension AppDelegate {
    //MARK: - 软件更新
    //    must (integer): 是否强制更新 1=是 2=否 ,
    //softwareType (integer): 软件类型：1=托运人 2=承运人 ,
    //terminalType (integer): 终端类型：1=ios 2=Android ,
    func updateSoftWare(){
        BaseApi.request(target: API.updateSoftWare(UpdateSoftWareModel()), type: BaseResponseModel<UpdateSoftWareModel>.self)
            .subscribe(onNext: { (model) in
                let upModel = model.data
                print("更新数据：\(String(describing: upModel))")
                if upModel?.softwareType == 1 && upModel?.terminalType == 1{
                    
                    //判断需不需要更新(CFBundleVersion:对应配置的build 不是version: 1.1.0)
                    let infoDic: Dictionary = Bundle.main.infoDictionary ?? Dictionary()
                    let str = infoDic["CFBundleVersion"] as? String ?? ""
                    let loccationVison = Int(str) ?? 0
                    let nowVison: Int = upModel?.versionCode ?? 0
                    
                    if (loccationVison < nowVison) {
                        if upModel?.must == 1{
                            //强制更新
                            self.showCusAlert(title: "重要提示", content:upModel?.content ?? "有新版本啦，为不影响您的使用，快去appStore升级吧！" , isMust: true)
                        }else{
                            //自由更新
                            self.showCusAlert(title: "重要提示", content:upModel?.content ?? "有新版本啦，快去appStore升级吧！" , isMust: false)
                        }
                    }
                    
                }
            }).disposed(by: dispose)
    }
    
    func showCusAlert(title: String, content: String, isMust: Bool)  {
        let alertVC = UIAlertController(title: title, message: content, preferredStyle: .alert)
        
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel) { (_) in
            
        }
        let sureAction = UIAlertAction(title: "去升级", style: .destructive) { (_) in
            
            let urlString = "itms-apps://itunes.apple.com/app/id1446242703"
            let url = URL.init(string: urlString)
            UIApplication.shared.openURL(url!)
            
        }
        
        if isMust == true {
            //强制更新
            alertVC.addAction(sureAction)
        }else{
            //自由更新
            alertVC.addAction(cancelAction)
            alertVC.addAction(sureAction)
        }
        
        window?.rootViewController?.present(alertVC, animated: true, completion: nil)
        
    }
    
    // 获取基础信息
    static func loadNormalInfo()  {
        
    }
    
    func configIQKeyboard() {
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().toolbarDoneBarButtonItemText = "确定"
        IQKeyboardManager.shared().toolbarBarTintColor = UIColor(hex: INPUTVIEW_TINCOLOR)
        IQKeyboardManager.shared().toolbarTintColor = UIColor(hex: COLOR_BUTTON)
        IQKeyboardManager.shared().shouldResignOnTouchOutside = true
        IQKeyboardManager.shared().keyboardDistanceFromTextField = 10
    }
    
    func configGlobalNavigationBar() {
        
    }
    
    func configGAODEMap() {
        AMapServices.shared().apiKey = GAODE_MAP_KEY
        AMapServices.shared().enableHTTPS = false
    }
    
    func configHUD() {
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setDefaultStyle(.light)
        SVProgressHUD.setFont(UIFont.systemFont(ofSize: 16))
        SVProgressHUD.setRingRadius(5)
    }
    
    // 如果本地保存了token的情况，直接进入主界面，免登陆
    func autoLogin() -> Void {
        let token = WDLCoreManager.shared().userInfo?.token
        window = UIWindow.init(frame: UIScreen.main.bounds)
        if token != nil && (token?.count ?? 0) > 0 {
            let rootVC = RootTabBarVC()
            rootVC.addControllers()
            window?.rootViewController = rootVC
        } else {
            let login = LoginVC()
            let naviVC = UINavigationController(rootViewController: login)
            window?.rootViewController = naviVC
        }
        window?.backgroundColor = UIColor.red
        window?.makeKeyAndVisible()
    }
    
   
    
    // 获取 托运人信息
    func loadConsignorInfo() -> Void {
        let id = WDLCoreManager.shared().userInfo?.id ?? ""
        let token = WDLCoreManager.shared().userInfo?.token ?? ""
        if token.count > 0 {
           let _ = BaseApi.request(target: API.getZbnConsignor(id), type: BaseResponseModel<ZbnConsignor>.self)
                .retry(2)
                .subscribe(onNext: { (data) in
                    var newInfo = data.data
                    let userInfo = WDLCoreManager.shared().userInfo
                    if (newInfo?.token?.count ?? 0) <= 0 {
                        newInfo?.token = userInfo?.token
                    }
                    WDLCoreManager.shared().userInfo = newInfo
                }, onError: { (error) in
                })
            WDLCoreManager.shared().loadUnReadMessage(closure: nil)
        }
    }
}

